# Common setup code to be included by all "*-fix-component-*" notebooks
# Notebooks should define constant named COMPONENT prior to including


isdefined(Main, :COMPONENT) || error("Define COMPONENT::Int global variable before including this file")


using JSON
using PlotlyJS
using CSV


# Include experiment packages
push!(LOAD_PATH, "src/");
using OverlapAnalysis
using OverlapPlots


# Misc setup
ENV["COLUMNS"] = 400


# Load data
od = load_overlap_data();
cdata = load_component_data(od, COMPONENT);


# Edits
edits = DatabaseEdits(cdata)

function complete_edits(edits::DatabaseEdits)
    assert_edits_successful(edits)
    
    open("data-intermediate/component-fixes/$COMPONENT.json", "w") do f
        JSON.print(f, edits)
    end
    
    summary = summarize_edits(edits)
    CSV.write("data-intermediate/component-fixes/$COMPONENT-summary.csv", summary)
    
    return summary
end


# Display component taxa and plots
display(sort(cdata.taxa, :outgoing, rev=true))
if cdata.ntaxa > 2
    display(plot_overlap_graph(cdata))
    display(plot(overlaps_heatmap(cdata)))
end
