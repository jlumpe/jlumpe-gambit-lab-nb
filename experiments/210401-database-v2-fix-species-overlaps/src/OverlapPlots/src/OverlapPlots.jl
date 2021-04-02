module OverlapPlots


using LinearAlgebra
using PlotlyJS
using LightGraphs
using GraphPlot
using Colors
using ColorSchemes
import Clustering

using ClusterAnalysis
using MidasPlots
using MidasPlots: ClassValues, dgleaf_edges
using MidasPlots.Plotly
using OverlapAnalysis: ComponentData, taxon_index, taxon_pw_dists, cluster_annotate


export plot_overlap_graph, overlaps_heatmap, clustermap, multi_clustermap, dendrogram


const CS_MAGMA = make_colorscale(:magma)
const UNCLASSIFIED_COLOR = colorant"#666"
const CLASS_COLORS = ClassValues(ColorSchemes.colorschemes[:tab20][2:2:end], UNCLASSIFIED_COLOR)


"""
Style a MidasPlots.Plotly.PlotlyDendrogram based on ClusterAnalysis.TreeAnnotations.
"""
function _style_dendrogram!(pdg::PlotlyDendrogram, ta::TreeAnnotations)
	hovertemplate = """
	ID: %{customdata[0]}<br>
	Height: %{$(pdg.horizontal ? "x" : "y"):.3f}<br>
	Genome count: %{customdata[1]}
	"""

	pdg.nodes_trace[:customdata] = [Any[id, ta.tree.nodes[id].count] for id in pdg.node_ids]

	if "strong_cluster" in names(ta.node_attrs)
		pdg.nodes_trace[:marker_size] = map(pdg.node_ids) do id
			nodeattrs(ta, id, :strong_cluster) ? 8 : 4
		end
	end

	if "class_label" in names(ta.node_attrs)
		pdg.nodes_trace[:marker_color] = CLASS_COLORS[nodeattrs(ta, pdg.node_ids, :class_label)]
		for (id, trace) in pdg.branch_traces
			trace[:line_color] = CLASS_COLORS[nodeattrs(ta, id, :class_label)]
		end

		# Add class names to hover
		if haskey(ta.attrs, :class_names)
			classnames = ta.attrs[:class_names]::AbstractVector
			if !(classnames isa ClassValues)
				classnames = ClassValues(classnames, "(mixed)")
			end

			hovertemplate *= "<br>\n%{customdata[2]}"

			for (id, data) in zip(pdg.node_ids, pdg.nodes_trace[:customdata])
				push!(data, classnames[nodeattrs(ta, id, :class_label)])
			end
		end

	else
		pdg.nodes_trace[:marker_color] = UNCLASSIFIED_COLOR
		for (id, trace) in pdg.branch_traces
			trace[:line_color] = UNCLASSIFIED_COLOR
		end
	end

	hovertemplate *= "\n<extra></extra>"
	pdg.nodes_trace[:hovertemplate] = hovertemplate

	return pdg
end


"""
Merge identical sink nodes in a graph together.
"""
function group_sink_nodes(g::SimpleDiGraph)
	is_sink = outdegree(g) .== 0
	am = adjacency_matrix(g)

	incoming_groups = Dict{Vector{Int}, Vector{Int}}()

	for i in findall(is_sink)
		incoming = findall(>(0), am[:, i])
		g = get!(incoming_groups, incoming, Int[])
		push!(g, i)
	end

	groups = [[i] for i in findall(!, is_sink)]
	append!(groups, values(incoming_groups))
	groups_first = first.(groups)

	gg = SimpleDiGraph(am[groups_first, groups_first])

	return gg, groups
end


"""
Plot graph of all overlaps in component.
"""
function plot_overlap_graph(cd::ComponentData)
	gg, groups = group_sink_nodes(cd.data[:graph])

	labels = map(groups) do group
		if length(group) == 1
			tidx = only(group)
			cd.taxa[tidx, :name_abbr]
		else
			string("(", length(group), " species)")
		end
	end

	gplot(
		gg,
#		 layout=circular_layout,
		nodelabel=labels,
		nodefillc=nothing,
		nodesize=3.,
	)
end


"""
Plot pairwise distances between taxa in overlap component, with overlaps marked.
Diagonal values are diameters.
"""
function overlaps_heatmap(cd::ComponentData)
	dmat = copy(cd.data[:pw_min_dists])
	tree = ClusterAnalysis.hclust(dmat, linkage=:complete)
	dg = Dendrogram(tree)

	dmat[diagind(dmat)] .= cd.taxa[!, :diameter]
	dmat = dmat[dg.leaves, dg.leaves]

	ax_labels = cd.taxa[!, :name_abbr]

	hm = heatmap(
		z=dmat,
		x=ax_labels[dg.leaves],
		y=ax_labels[dg.leaves],
		colorscale=CS_MAGMA,
	)

	# Mark overlaps
	ox = String[]
	oy = String[]
	for e in edges(cd.data[:graph])
		push!(oy, ax_labels[e.src])
		push!(ox, ax_labels[e.dst])
	end

	overlap_markers = scatter(
		x=ox,
		y=oy,
		mode=:markers,
		hoverinfo=:skip,
		marker_color="red",
	)

	layout = Layout(
		xaxis=attr(
			tickangle=-90,
			scaleanchor="y",
		),
		width=800,
		height=700,
		margin_l=150,
		margin_b=150,
	)

	return Plot([hm, overlap_markers], layout)
end


function _add_inter_taxon_dists!(plt, cd::ComponentData, ti::Int; color="green")
	diam = cd.taxa[ti, :diameter]
	min_dists = cd.data[:pw_min_dists][ti, :]

	idxs = [tj for (tj, d) in enumerate(min_dists) if d <= diam && tj != ti]
	sort!(idxs, by=i -> min_dists[i])

	addtraces!(plt, scatter(
		x=min_dists[idxs],
		y=fill(-1, length(min_dists)),
		text=cd.taxa[idxs, :name_abbr],
		xaxis="x2",
		mode="markers",
		hovertemplate="""
		%{text} <br>
		%{x}
		<extra></extra>
		""",
		marker_symbol="line-ns",
		marker_color=color,
		marker_line_color=color,
		marker_line_width=1,
	))

	relayout!(plt, xaxis2=attr(
		showspikes=true,
		spikemode=:across,
		spikethickness=1,
		spikedash=:solid,
	))
end


function _make_dendrogram(ta::TreeAnnotations; min_leaves::Int=20, max_leaves::Int=50, max_height::Float64=Inf)
	tree = ta.tree
	tree.n <= min_leaves && return Dendrogram(ta.tree)

	# Starting cut - include everything above max height
	cut = if max_height < Inf
		findcut(tree, h=max_height)
	else
		[tree.root_id]
	end

	# First pass, all strong + single-class up to max_leaves
	function accept_cut(node)
		node.id == tree.root_id && return true
		row = nodeattrs(ta, node.id)
		return get(row, :class_label, 1) == 0 || !get(row, :strong_cluster, true)
	end

	cut = ClusterAnalysis.refine_cut(tree, cut, k=min(max_leaves, tree.n), accept=accept_cut)

	# Refine if under min_leaves
	if length(cut) < min_leaves
		cut = refine_cut(tree, cut, k=min_leaves)
	end

	# 2nd pass if still over max_leaves
	if length(cut) > max_leaves
		@warn "TODO"
	end

	@assert length(cut) > 1
	return Dendrogram(tree, trunc=node -> node.id ∈ cut)
end


function _get_clustermap_dmat(dmat::AbstractMatrix, tree::HClustTree, dg::Dendrogram)
	if any(dg.nodes[i].truncated for i in dg.leaves)
		return ClusterAnalysis.hclust_node_dists(tree, dmat, dg.leaves)
	else
		return view(dmat, dg.leaves, dg.leaves)
	end
end


function _class_color_strip(cd::ComponentData, ta::TreeAnnotations, dg::Dendrogram; vertical::Bool, gap::Int=1)
	class_names = ClassValues(ta.attrs[:class_names], "(mixed)")
	class_labels = nodeattrs(ta, dg.leaves, :class_label)

	return class_color_strip(
		class_labels,
		CLASS_COLORS,
		vertical=vertical,
		edges=dgleaf_edges(dg),
		gap=gap,
		customdata=[
			[
				ClusterAnalysis.isleaf(ta.tree, i) ? "Genome $i" : "ID $i",
				class_names[nodeattrs(ta, i, :class_label)],
			]
			for i in dg.leaves
		],
		hovertemplate="""
		%{customdata[0]} <br>
		%{customdata[1]}
		<extra></extra>
		""",
	)
end


function _clustermap_base(ta::TreeAnnotations; kw...)
	dg = _make_dendrogram(ta; kw...)
	dmat = _get_clustermap_dmat(ta.attrs[:dmat], ta.tree, dg)
	cm = symmetric_clustermap(dmat, dg, dg_frac=0.5, ordered=true)

	cm.heatmap[:colorscale] = CS_MAGMA
	_style_dendrogram!(cm.row_dg, ta)

	plt = Plot(cm)

	relayout!(
		plt,
		width=1000,
		height=550,
	)

	return plt, dg, cm
end


function clustermap(cd::ComponentData, taxon; kw...)
	ta = cluster_annotate(cd, taxon)
	return clustermap(cd, ta; kw...)
end


function clustermap(cd::ComponentData, ta::TreeAnnotations; inter_dists::Bool=true, kw...)
	plt, dg, cm = _clustermap_base(ta; kw...)

	if inter_dists
		_add_inter_taxon_dists!(plt, cd, ta.attrs[:taxon])
	end

	return plt
end


function multi_clustermap(cd::ComponentData, taxa; kw...)
	ta = cluster_annotate(cd, taxa)
	return multi_clustermap(cd, ta; kw...)
end


"""
Cluster map of multiple taxa.
"""
function multi_clustermap(cd::ComponentData, ta::TreeAnnotations; kw...)
	tidxs = ta.attrs[:taxa]
	plt, dg, cm = _clustermap_base(ta; kw...)

	# Create color strip
	colorstrip = _class_color_strip(cd, ta, dg, vertical=true)
	colorstrip[:xaxis] = "x3"
	addtraces!(plt, colorstrip)

	# Re-arrange x axes
	plt.layout[:xaxis3] = attr(visible=false, fixedrange=true)
	MidasPlots.Plotly.subplot_axes!(
		[plt.layout[a] for a in [:xaxis2, :xaxis3, :xaxis]],
		[.5, .025, .5],
		sep=.01,
	)

	relayout!(
		plt,
		xaxis_constrain=:domain,
		width=1000,
		height=500,
	)

	plt
end


function dendrogram(cd::ComponentData, taxa; kw...)
	ta = cluster_annotate(cd, taxa)
	return dendrogram(cd, ta; kw...)
end

function dendrogram(cd::ComponentData, ta::TreeAnnotations; kw...)
	dg = _make_dendrogram(ta; kw...)
	pdg = PlotlyDendrogram(dg, attr(yaxis="y1"))
	_style_dendrogram!(pdg, ta)

	plt = Plot(pdg)

	colorstrip = _class_color_strip(cd, ta, dg, vertical=false)
	colorstrip[:yaxis] = "y2"
	addtraces!(plt, colorstrip)

	plt.layout[:xaxis] = attr(
		visible=false,
	)
	plt.layout[:yaxis2] = attr(
		visible=false,
		fixedrange=true,
	)
	MidasPlots.Plotly.subplot_axes!([plt.layout[:yaxis2], plt.layout[:yaxis]], [.05, .95])

	return plt
end


end # module
