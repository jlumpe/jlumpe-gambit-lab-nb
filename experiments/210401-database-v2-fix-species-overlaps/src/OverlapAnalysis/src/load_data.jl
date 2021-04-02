export load_overlap_data, load_component_data


INFILES = Dict(
	:distances => p"data/intermediate/200727-find-overlaps/genome-pw-distances.raw-float32",
	:db => p"data/intermediate/210303-database-v2-overlaps/210328-compile-edits/",
	:overlaps => p"data/intermediate/210303-database-v2-overlaps/210328-find-species-overlaps-2/",
)


function load_overlap_data(project_root="../..")
	project_root = Path(project_root)

	# Load database stuff
	taxa_df = DataFrame(CSV.File(project_root / INFILES[:db] / "taxa.csv"))
	genome_assignments = Vector{Int}(open(JSON.parse, project_root / INFILES[:db] / "genome-taxon-assignments.json"))
	ngenomes = length(genome_assignments)

	# Load distances
	pw_data = Mmap.mmap(open(project_root / INFILES[:distances]), Vector{Float32}, (npairs(ngenomes),))
	pw_dists = TriMatrix(TriSymmetric{false}(), ngenomes, pw_data)

	# Load overlap data
	components = open(JSON.parse, project_root / INFILES[:overlaps] / "components.json")

	return OverlapData(
		taxa_df,
		ngenomes,
		genome_assignments,
		pw_dists,
		components,
	)
end


"""
Get data for the analysis of specific overlap component.
"""
function load_component_data(od::OverlapData, ci::Int)
	item = od.components[ci]
	comp_tids = Vector{Int}(item["taxon_ids"])

	# Genome indices for each taxon in component
	comp_idx_by_tid = Dict(tid => i for (i, tid) in enumerate(comp_tids))

	genome_idxs = [Int[] for _ in comp_tids]

	for (gidx, tid) in enumerate(od.genome_assignments)
		if haskey(comp_idx_by_tid, tid)
			push!(genome_idxs[comp_idx_by_tid[tid]], gidx)
		end
	end

	# DataFrame of taxa in this component, extra info added
	taxa = od.taxa[indexin(comp_tids, od.taxa[!, :id]), :]
	@assert all(taxa[!, :is_leaf])
	select!(taxa, BASE_TAXA_COLS)

	cd = ComponentData(od, taxa, genome_idxs)

	# Calculate and add additional data
	_calc_distance_data!(cd)
	_calc_overlap_data!(cd)
	taxa[!, :name_abbr] = make_name_abbrs(taxa[!, :name])
	cd.data[:parent_taxa] = select!(empty(od.taxa), BASE_TAXA_COLS)

	# Validate
	validate_component_data(cd)

	# Check that calculated overlaps match those in data
	graph = SimpleDiGraphFromIterator(Edge(pair...) for pair in item["edges"])
	@assert graph == cd.data[:graph]

	return cd
end
