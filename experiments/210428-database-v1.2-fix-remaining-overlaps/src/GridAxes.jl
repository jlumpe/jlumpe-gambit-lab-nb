module GridAxesModule


using PlotlyBase: PlotlyAttribute
using PlotlyJS
using MidasPlots.Plotly: subplot_axes, axisname
import MidasPlots.Plotly: setaxes!


export GridAxes


struct GridAxes
    nrow::Int
    ncol::Int
    xaxes::Vector{PlotlyAttribute}
    yaxes::Vector{PlotlyAttribute}
    xaxes_grid::AbstractMatrix{PlotlyAttribute}
    yaxes_grid::AbstractMatrix{PlotlyAttribute}
    xindices::Matrix{Int}
    yindices::Matrix{Int}

    function GridAxes(
        rows::Union{Integer, AbstractVector{<:Real}},
        cols::Union{Integer, AbstractVector{<:Real}};
        sharex::Bool=false,
        sharey::Bool=false,
        base::PlotlyAttribute=attr(),
        xbase::PlotlyAttribute=base,
        ybase::PlotlyAttribute=base,
        xsep::Real=0.,
        ysep::Real=0.,
        flipy::Bool=false
        )

        xaxes_base = subplot_axes(cols, xbase, sep=xsep)
        yaxes_base = subplot_axes(rows, ybase, sep=ysep)
        flipy && reverse!(yaxes_base)

        nrow = length(yaxes_base)
        ncol = length(xaxes_base)
        ncells = nrow * ncol

        if sharex
            xaxes = xaxes_base
            xaxes_grid = [ax for _ in 1:nrow, ax in xaxes]
            xindices = [i for _ in 1:nrow, i in 1:ncol]
        else
            xaxes_grid = [deepcopy(ax) for _ in 1:nrow, ax in xaxes_base]
            xaxes = reshape(xaxes_grid, :)
            xindices = reshape(1:ncells, nrow, ncol)
        end

        if sharey
            yaxes = yaxes_base
            yaxes_grid = [ax for _ in 1:nrow, ax in yaxes]
            yindices = [i for i in 1:nrow, _ in 1:ncol]
        else
            yaxes_grid = [deepcopy(ax) for ax in yaxes_base, _ in 1:ncol]
            yaxes = reshape(yaxes_grid, :)
            yindices = reshape(1:ncells, nrow, ncol)
        end

        # Set anchor attribute
        if !sharex
            for (xax, yidx) in zip(xaxes_grid, yindices)
                xax[:anchor] = axisname(:y, yidx)
            end
        end

        if !sharey
            for (yax, xidx) in zip(yaxes_grid, xindices)
                yax[:anchor] = axisname(:x, xidx)
            end
        end

        return new(nrow, ncol, xaxes, yaxes, xaxes_grid, yaxes_grid, xindices, yindices)
    end
end


Base.show(io::IO, ga::GridAxes) = print(io, "$(ga.nrow) x $(ga.ncol) GridAxes")

setaxes!(layout::Layout, ga::GridAxes) = setaxes!(layout, ga.xaxes, ga.yaxes)

setaxes!(trace::GenericTrace, ga::GridAxes, i) = setaxes!(trace, ga.xindices[i], ga.yindices[i])
setaxes!(trace::GenericTrace, ga::GridAxes, i, j) = setaxes!(trace, ga.xindices[i, j], ga.yindices[i, j])


end  #module
