"""
Struct containing global data for database taxonomy, pairwise distances, and overlaps.
"""
struct OverlapData
	taxa::DataFrame
	ngenomes::Int
	genome_assignments::Vector{Int}
	pw_dists::AbstractMatrix
	components
end


const BASE_TAXA_COLS = [:id, :ncbi_id, :name, :rank, :parent_id, :in_v12, :manual_threshold, :report]
const ADDL_TAXA_COLS = [:ngenomes, :comp_idx, :diameter, :outgoing, :incomong, :name_abbr]


"""
Struct containing data on a single overlap component.
"""
struct ComponentData
	"""Full overlap data"""
	od::OverlapData
	"""Number of leaf taxa"""
	ntaxa::Int
	"""Leaf taxa"""
	taxa::DataFrame
	"""Indices of genomes in leaf taxa"""
	genome_idxs::Vector{Vector{Int}}
	"""Additional data"""
	data::Dict{Symbol, Any}

	function ComponentData(od, taxa, genome_idxs)
		ntaxa = nrow(taxa)
		@assert length(genome_idxs) == ntaxa

		taxa[:, :ngenomes] = length.(genome_idxs)
		taxa[:, :comp_idx] = 1:ntaxa

		return new(od, ntaxa, taxa, genome_idxs, Dict{Symbol, Any}())
	end
end


Base.show(io::IO, cd::ComponentData) = print(io, typeof(cd), " with ", cd.ntaxa, " taxa")


"""
Convert to index of taxon in component, accepting numerical index or name/abbreviation.
"""
taxon_index(cd::ComponentData, i::Integer) = Int(i)

function taxon_index(cd::ComponentData, name::AbstractString)
	i = findfirst(==(name), cd.taxa[!, :name])
	if isnothing(i)
		i = findfirst(==(name), cd.taxa[!, :name_abbr])
	end
	isnothing(i) && error("No taxon with name/abbreviation \"$name\"")
	return i
end

taxon_index_by_id(cd::ComponentData, tid::Int) = findfirst(==(tid), cd.taxa[!, :id])


# Abbreviated taxon names, for use in plots
function make_name_abbrs(names)
	splits = [split(name, limit=2) for name in names]

	# All genera the same?
	if length(unique(first.(splits))) == 1
		# Remove genera entirely
		return last.(splits)
	else
		# Abbreviate genera
		return [string(first(a), ". ", b) for (a, b) in splits]
	end
end


function validate_component_data(cd::ComponentData)
	@assert nrow(cd.taxa) == cd.ntaxa
	@assert length(cd.genome_idxs) == cd.ntaxa

	if haskey(cd.data, :pw_min_dists)
		@assert size(cd.data[:pw_min_dists]) == (cd.ntaxa, cd.ntaxa)
	end

	# Check taxon genome indices disjoint and not empty
	seen_gidxs = Set{Int}()
	for gidxs in cd.genome_idxs
		@assert !isempty(gidxs)
		length(gidxs) < 2 && @warn "Taxon has <2 genomes"
		@assert isdisjoint(seen_gidxs, gidxs)
		union!(seen_gidxs, gidxs)
	end
end
