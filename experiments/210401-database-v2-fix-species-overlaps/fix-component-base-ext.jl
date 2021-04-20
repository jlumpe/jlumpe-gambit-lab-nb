# Extension to fix-components-base.jl on 210420, include that first.
# Adds hacky 2nd method to complete_edits


function get_subgroup_threshold_data(edits, edits2)
    @assert isempty(edits2.removed_taxa)
    @assert isempty(edits2.removed_genomes)
    @assert isempty(edits2.split_taxa)

    parents_df = cdata2.data[:parent_taxa]
    data = Any[]

    for (ti, thresh) in edits2.manual_thresholds
        taxon = edits2.cd.taxa[ti, :]
        index = parse(Int, match(r".* subgroup (\d+)", taxon[:name]).captures[1])
        push!(data, Dict(
            "parent_id" => taxon[:parent_id],
            "subgroup_index" => index,
            "threshold" => thresh,
        ))
    end

    return data
end


# 2nd edits to support saving manual thresholds for subgroups created in 1st round of edits
# No other edit types in 2nd arg supported
function complete_edits(edits::DatabaseEdits, edits2::DatabaseEdits; force::Bool=false)
    try
        assert_edits_successful(edits2)
    catch e
        if force && e isa AssertionError
            @warn "Overlaps not resolved, writing results anyway with force=true"
        else
            throw(e)
        end
    end

    open("data-intermediate/component-fixes/$COMPONENT.json", "w") do f
        JSON.print(f, edits)
    end

    summary = summarize_edits(edits)
    CSV.write("data-intermediate/component-fixes/$COMPONENT-summary.csv", summary)

    if !isnothing(edits2)
        data = get_subgroup_threshold_data(edits, edits2)
        open("data-intermediate/component-fixes/$COMPONENT-subgroup-thresholds.json", "w") do f
            JSON.print(f, data)
        end
    end

    return summary
end
