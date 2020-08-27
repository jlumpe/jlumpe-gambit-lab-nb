module GroupedHeatmaps

using PlotlyJS
using PlotlyBase: PlotlyAttribute
using Clustering: hclust

export GroupedHeatmap


function make_domains(sizes::AbstractVector{<:Real}, pad::Float64, maxpad::Real=.25)
    n = length(sizes)
    padsum = min(pad * (n - 1), maxpad)
    pad = padsum / (n - 1)
    scale = (1 - padsum) / sum(sizes)
    
    start = 0.
    domains = Tuple{Float64, Float64}[]
    for s in sizes
        push!(domains, (0., s * scale) .+ start)
        start += s * scale + pad
    end
    
    return domains
end


struct GroupedHeatmap
    ngroups::Int
    groups::Vector{Vector{Int}}
    heatmaps::Matrix{GenericTrace}
    axes::Vector{PlotlyAttribute}
    layout::Layout
    plot::Plot
end


Base.show(io::IO, gh::GroupedHeatmap) = print(typeof(gh), " with $(gh.ngroups) groups")


function GroupedHeatmap(dists::AbstractMatrix, groups::AbstractVector{<:Vector{<:Integer}};
        labels=nothing,
        grouplabels=nothing,
        linkage::Symbol=:complete,
        height::Int=1000,
        width::Int=round(Int, height*1.0),
        pad=0.005,
        colorscale="Viridis")
    
    ng = length(groups)
    gsizes = length.(groups)
    
    # Reorder group indices according to dendrogram
    gidxs = map(groups) do g
        h = hclust(dists[g, g], linkage=linkage, branchorder=:optimal)
        g[h.order]
    end
    
    heatmaps = Array{GenericTrace}(undef, ng, ng)
    for (i, ii) in enumerate(gidxs)
        for (j, jj) in enumerate(gidxs)
            dij = dists[ii, jj]
            
            l1, l2 = isnothing(grouplabels) ? ("$i", "$j") : grouplabels[[i, j]]
            
            tr = PlotlyJS.heatmap(
                z=dij,
                coloraxis="coloraxis",
                xaxis="x$i",
                yaxis="y$j",
                name=i == j ? l1 : "$l1 / $l2",
            )
            if !isnothing(labels)
                tr["x"] = labels[ii]
                tr["y"] = labels[jj]
            end
        
            heatmaps[i, j] = tr
        end
    end

    domains = make_domains(gsizes, pad)
    axes = PlotlyAttribute[]
    axes_dict = Dict{Symbol, Any}()

    for i in 1:ng
        ax = attr(
            domain=domains[i],
            ticks="",
            showticklabels=false,
            range=[-.5, gsizes[i] - .5],
        )
        !isnothing(grouplabels) && (ax["title"] = grouplabels[i])
        if !isnothing(labels)
            ax["categoryorder"] = "array"
            ax["categoryarray"] = labels[gidxs[i]]
        end
        
        push!(axes, ax)
        axes_dict[Symbol("xaxis$i")] = axes_dict[Symbol("yaxis$i")] = ax
    end
    
    layout = PlotlyJS.Layout(
        coloraxis=attr(colorscale=colorscale),
        width=width,
        height=height,
        ; axes_dict...
    )
    
    plot = PlotlyJS.Plot(vec(heatmaps), layout)
    
    return GroupedHeatmap(ng, gidxs, heatmaps, axes, layout, plot)
end


end  # module