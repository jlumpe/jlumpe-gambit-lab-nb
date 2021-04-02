export taxon_pw_dists, cluster_taxon, cluster_annotate, print_overlaps


"""
Get pairwise distances for two sets of taxa.
"""
function taxon_pw_dists(cd::ComponentData, t1, t2)
	i = taxon_index(cd, t1)
	j = taxon_index(cd, t2)
	return view(cd.od.pw_dists, cd.genome_idxs[i], cd.genome_idxs[j])
end

taxon_pw_dists(cd::ComponentData, taxon) = taxon_pw_dists(cd, taxon, taxon)


"""
Cluster all genomes from a single taxon.
"""
function cluster_taxon(cd::ComponentData, taxon, linkage=:complete)
	dmat = taxon_pw_dists(cd, taxon)
	return ClusterAnalysis.hclust(dmat, linkage=linkage)
end

"""
Cluster all genomes from a single taxon and add annotations.
"""
function cluster_annotate(cd::ComponentData, taxon, linkage=:complete)
	tidx = taxon_index(cd, taxon)
	gidxs = cd.genome_idxs[tidx]
	dmat = view(cd.od.pw_dists, gidxs, gidxs)

	tree = ClusterAnalysis.hclust(dmat, linkage=linkage)
	ta = TreeAnnotations(tree, Dict(:dmat => dmat, :taxon => tidx))

	annotate!(:strong_cluster, ta)
	nodeattrs!(i -> gidxs[i], ta, :genome_idx, leaves_only=true)

	return ta
end

"""
Cluster genomes from multiple taxa and add annotations.
"""
function cluster_annotate(cd::ComponentData, taxa::AbstractArray, linkage=:complete)
	tidxs = [taxon_index(cd, taxon) for taxon in taxa]
	gidxs = vcat(cd.genome_idxs[tidxs]...)
	dmat = view(cd.od.pw_dists, gidxs, gidxs)

	tree = ClusterAnalysis.hclust(dmat, linkage=linkage)

	ta = TreeAnnotations(tree)
	ta.attrs[:dmat] = dmat
	ta.attrs[:taxa] = tidxs
	ta.attrs[:class_names] = cd.taxa[tidxs, :name_abbr]

	annotate!(:strong_cluster, ta)
	nodeattrs!(i -> gidxs[i], ta, :genome_idx, leaves_only=true)
	annotate!(:class_label, ta, vcat((fill(i, n) for (i, n) in enumerate(cd.taxa[tidxs, :ngenomes]))...))

	return ta
end


function _calc_distance_data!(cd::ComponentData)
	cd.taxa[:, :diameter] = [maximum(taxon_pw_dists(cd, i)) for i in 1:cd.ntaxa]

	pw_min_dists = zeros(eltype(cd.od.pw_dists), cd.ntaxa, cd.ntaxa)
	for (i, j) in iterpairs(cd.ntaxa)
		d = minimum(taxon_pw_dists(cd, i, j))
		pw_min_dists[i, j] = pw_min_dists[j, i] = d
	end

	cd.data[:pw_min_dists] = pw_min_dists
end


function get_threshold(cd::ComponentData, taxon)
	row = cd.taxa[taxon_index(cd, taxon), :]
	return isnan(row[:manual_threshold]) ? row[:diameter] : row[:manual_threshold]
end


function _calc_overlap_data!(cd::ComponentData)
	thresholds = get_threshold.(Ref(cd), 1:cd.ntaxa)
	graph = cd.data[:graph] = SimpleDiGraph(cd.ntaxa)

	for (i, j) in iterpairs(cd.ntaxa)
		d = cd.data[:pw_min_dists][i, j]
		d <= thresholds[i] && (@assert add_edge!(graph, Edge(i, j)))
		d <= thresholds[j] && (@assert add_edge!(graph, Edge(j, i)))
	end

	cd.taxa[:, :outgoing] = outdegree(graph)
	cd.taxa[:, :incoming] = indegree(graph)
end


has_overlaps(cd::ComponentData) = !isempty(edges(cd.data[:graph]))
assert_no_overlaps(cd::ComponentData) = @assert !has_overlaps(cd)


"""
Prints list of all overlap edges in component.
"""
function print_overlaps(cd::ComponentData)
	dsts_by_src = Dict{Int, Vector{Int}}()

	for e in edges(cd.data[:graph])
		push!(get!(dsts_by_src, e.src, Int[]), e.dst)
	end

	# None left
	if isempty(dsts_by_src)
		println("No overlaps remaining!")
		return
	end

	for src in sort!(collect(keys(dsts_by_src)))
		println("#$src ", cd.taxa[src, :name_abbr])
		for dst in dsts_by_src[src]
			println("\t=> #$dst ", cd.taxa[dst, :name_abbr])
		end
	end
end
