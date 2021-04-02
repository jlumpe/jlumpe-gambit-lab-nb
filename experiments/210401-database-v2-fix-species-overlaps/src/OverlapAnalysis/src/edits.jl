export DatabaseEdits, remove_subtrees!, keep_subtrees!, split_taxon!, set_threshold!,
	apply_edits, summarize_edits, assert_edits_successful, check_edit_progress


struct DatabaseEdits
	cd::ComponentData
	"""Removed taxon indices"""
	removed_taxa::Set{Int}
	"""Removed genome indices"""
	removed_genomes::Set{Int}
	"""Map from taxon indices to manual threhsold values"""
	manual_thresholds::Dict{Int, Float64}
	"""Map from taxon indices to vectors of vectors of genome indices."""
	split_taxa::Dict{Int, Vector{Vector{Int}}}

	DatabaseEdits(cd::ComponentData) = new(
		cd,
		Set{Int}(),
		Set{Int}(),
		Dict{Int, Float64}(),
		Dict{Int, Vector{Vector{Int}}}(),
	)
end


function _subtree_genome_idxs(ta::TreeAnnotations, id::Integer)
	idxs = nodeattrs(ta, ClusterAnalysis.leaves(ta.tree, id), :genome_idx)
	return convert(Vector{Int}, idxs)
end


function _summarize_removed_genomes(cd::ComponentData, removed_gidxs)
	for (ti, gidxs) in enumerate(cd.genome_idxs)
		removed = intersect(removed_gidxs, gidxs)
		isempty(removed) && continue

		remaining = setdiff(gidxs, removed)
		diam = maximum(view(cd.od.pw_dists, remaining, remaining))

		@printf "#%d %s:\n" ti cd.taxa[ti, :name_abbr]
		@printf "\t%d/%d removed\n" length(removed) length(gidxs)
		@printf "\tDiameter %.4f => %.4f\n" cd.taxa[ti, :diameter] diam
	end
end


function remove_subtrees!(edits::DatabaseEdits, ta::TreeAnnotations, subtree_ids)
	to_delete = reduce(vcat, (_subtree_genome_idxs(ta, id) for id in subtree_ids))

	_summarize_removed_genomes(edits.cd, to_delete)
	union!(edits.removed_genomes, to_delete)

	nothing
end


function keep_subtrees!(edits::DatabaseEdits, ta::TreeAnnotations, subtree_ids)
	to_keep = reduce(vcat, (_subtree_genome_idxs(ta, id) for id in subtree_ids))
	to_delete = collect(setdiff(_subtree_genome_idxs(ta, ta.tree.root_id), to_keep))

	_summarize_removed_genomes(edits.cd, to_delete)
	union!(edits.removed_genomes, to_delete)

	nothing
end


function split_taxon!(edits::DatabaseEdits, ta::TreeAnnotations, subtree_ids)
	tidx = ta.attrs[:taxon]::Integer

	subgroup_genomes = [_subtree_genome_idxs(ta, id) for id in subtree_ids]

	for (i, gidxs) in enumerate(subgroup_genomes)
		println("Subgroup $i size: ", length(gidxs))
	end

	to_delete = setdiff(edits.cd.genome_idxs[tidx], subgroup_genomes...)
	println("Genomes to delete: ", length(to_delete))

	edits.split_taxa[tidx] = subgroup_genomes
	union!(edits.removed_genomes, to_delete)

	nothing
end


function set_threshold!(edits::DatabaseEdits, taxon, thresh)
	edits.manual_thresholds[taxon_index(edits.cd, taxon)] = thresh
end


"""
Reset edits instance.
"""
function Base.empty!(edits::DatabaseEdits)
	empty!(edits.removed_taxa)
	empty!(edits.removed_genomes)
	empty!(edits.manual_thresholds)
	empty!(edits.split_taxa)
	return edits
end


"""
Assert edits have no inconsistencies.
"""
function validate_edits(edits::DatabaseEdits)
	tidxs = 1:edits.cd.ntaxa

	# Check taxon indices
	@assert issubset(edits.removed_taxa, tidxs)
	@assert issubset(keys(edits.manual_thresholds), tidxs)
	@assert issubset(keys(edits.split_taxa), tidxs)

	# Split taxa and manual threshold edits don't overlap with removed taxa
	@assert isdisjoint(edits.removed_taxa, edits.manual_thresholds)
	@assert isdisjoint(edits.removed_taxa, edits.split_taxa)

	# Each subgroup in splits has >= 2 genomes
	for (parentidx, subgroup_gidxs) in edits.split_taxa
		for gidxs in subgroup_gidxs
			@assert length(gidxs) >= 2
		end
	end
end


"""
Create summary table of edits by taxon.
"""
function summarize_edits(edits::DatabaseEdits)

	df = map(enumerate(eachrow(edits.cd.taxa))) do (ti, row)
		gidxs = edits.cd.genome_idxs[ti]
		taxremoved = ti ∈ edits.removed_genomes
		nremoved = length(intersect(gidxs, edits.removed_genomes))

		split_str = if haskey(edits.split_taxa, ti)
			sizes = map(length, edits.split_taxa[ti])
			join(map(string, sizes), ", ")
		else
			""
		end

		if taxremoved
			final_diameter = missing
		else
			group_genomes = get(edits.split_taxa, ti, [setdiff(gidxs, edits.removed_genomes)])
			diams = [maximum(view(edits.cd.od.pw_dists, gidxs, gidxs)) for gidxs in group_genomes]
			final_diameter = join((@sprintf("%.4f", d) for d in diams), ", ")
		end

		return (
			index=ti,
			name=row[:name_abbr],
			ngenomes=row[:ngenomes],
			initial_diameter=row[:diameter],
			taxon_removed=taxremoved,
			removed_genomes=nremoved,
			split=split_str,
			manual_threshold=get(edits.manual_thresholds, ti, missing),
			final_diameter=final_diameter,
		)
	end |> DataFrame

	return filter!(df) do row
		(row[:taxon_removed]
			|| row[:removed_genomes] > 0
			|| !isempty(row[:split])
			|| !ismissing(row[:manual_threshold]))
	end
end


function _make_subgroup_taxon(parent::DataFrameRow, i::Int, next_id::Int)
	return (
		id=next_id,
		ncbi_id=nothing,
		name=string(parent[:name], " subgroup ", i),
		name_abbr=string(parent[:name_abbr], " subgroup ", i),
		rank=nothing,
		parent_id=parent[:id],
		in_v12=false,
		manual_threshold=NaN,
		report=false,
	)
end


"""
Apply edits to create a new ComponentData instance.
"""
function apply_edits(edits::DatabaseEdits)
	cd = edits.cd

	taxa_out = empty(cd.taxa)
	gidxs_out = Vector{Int}[]
	parent_taxa = copy(cd.data[:parent_taxa])

	next_id = maximum(cd.taxa[!, :id]) + 1

	# Process taxa
	for (ti, row) in enumerate(eachrow(cd.taxa))
		# Taxon was split
		if haskey(edits.split_taxa, ti)
			split_gidxs = edits.split_taxa[ti]

			# Add parent to new component
			push!(parent_taxa, row, cols=:intersect)

			# Add subgroups
			for (i, gidxs) in enumerate(split_gidxs)
				push!(taxa_out, _make_subgroup_taxon(row, i, next_id), cols=:subset)
				push!(gidxs_out, gidxs)

				next_id += 1
			end

		# Taxon not deleted
		elseif !(ti in edits.removed_taxa)
			push!(taxa_out, row)
			push!(gidxs_out, copy(cd.genome_idxs[ti]))
		end
	end

	# Remove deleted genomes
	for gidxs in gidxs_out
		setdiff!(gidxs, edits.removed_genomes)
	end

	# Apply manual thresholds
	for (ti, thresh) in edits.manual_thresholds
		taxa_out[ti, :manual_threshold] = thresh
	end

	cd_out = ComponentData(cd.od, taxa_out, gidxs_out)

	_calc_distance_data!(cd_out)
	_calc_overlap_data!(cd_out)
	cd_out.data[:parent_taxa] = parent_taxa

	validate_component_data(cd_out)

	return cd_out
end


"""
Asserts edits are valid and when applied produce a valid ComponentData instance with no overlaps.
"""
function assert_edits_successful(edits::DatabaseEdits)
	validate_edits(edits)
	edited = apply_edits(edits)
	validate_component_data(edited)
	assert_no_overlaps(edited)
	nothing
end


"""
Print overlaps that will remain after edits are applied.
"""
function check_edit_progress(edits::DatabaseEdits)
	edited = apply_edits(edits)
	print_overlaps(edited)
end


function JSON.lower(edits::DatabaseEdits)
	items = []

	for (ti, tid) in enumerate(edits.cd.taxa[!, :id])
		gidxs = edits.cd.genome_idxs[ti]

		item = (
			taxon_id=tid,
			removed=ti ∈ edits.removed_taxa,
			removed_genomes=intersect(gidxs, edits.removed_genomes),
			split=get(edits.split_taxa, ti, nothing),
			manual_threshold=get(edits.manual_thresholds, ti, nothing),
		)

		if item.removed || !isempty(item.removed_genomes) || !isnothing(item.split) || !isnothing(item.manual_threshold)
			push!(items, item)
		end
	end

	return items
end
