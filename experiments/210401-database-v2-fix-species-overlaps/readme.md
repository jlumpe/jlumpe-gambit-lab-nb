# 210401 Database v2 Fix Species Overlaps

This experiment aims to fix all species-species overlaps in v1.2 of the database, taking off where the previous experiment (`210303-database-v2-overlaps`) left off.
That experiment applied some minor edits to v1.2 and then located all remaining species-species overlaps.


## Source files

### `src/OverlapAnalysis/`

Experiment-specific package containing code to load, manipulate, and examine overlap component data.
Defines the `DatabaseEdits` type, used to record, validate, and save all edits needed to fix most
components.


### `src/OverlapPlots/`

Plot funcs for data from `OverlapAnalysis`, like cluster maps and dendrograms.


### `fix-component-base.jl`

Common source file to be included in all component fix notebooks. Imports `OverlapAnalysis` and
`OverlapPlots` packages, loads data for given component, displays summary table and plots. Also
sets up an empty `DatabaseEdits` object and a function `complete_edits` which confirms the edits
object has resolved all overlaps and then saves it.


### `fix-component-base-ext.jl`

Defines a second method to `complete_edits` which accepts another `DatabaseEdits` object containing
manual thresholds to subgroups created in the first.


## Notebooks

### XXXXXX-fix-component-X

Notebooks to fix each of the 34 individual overlap components. All are initialized by including the
`fix-component-base.jl` source file to load the overlap component data. Overlaps are resolved by
saving edits to a `DatabaseEdits` object which is then saved to `data-intermediate/component-fixes/`.
See `component-fix-descriptions.md` for descriptions of each individual file.


## Other files

* `component-fix-descriptions.md` - Description of process used to fix overlaps for each component.


## Output

* `data/intermediate/210401-database-v2-fix-species-overlaps/`
  * `component-fixes/`
    * `{X}.json` - serialized `DatabaseEdits` object for fixes to each component.
    * `{X}-summary.csv` - human-readable table summarizing edits to each component. NOTE - after
      these had all been written that the `taxon_removed` column is incorrect, ignore.
    * `{X}-subgroup-thresholds.csv` - manual thresholds assigned to subgroups defined in main edits
	  edits file.
