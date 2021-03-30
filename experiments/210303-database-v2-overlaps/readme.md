# 210303 Database v1.2 overlaps


TODO purpose



## Notebooks

### 210303-format-data

Reads relevant data for this experiment from different sources, performs some pre-processing, and saves them to CSV and JSON files for easy use from Julia. Genome and taxonomy info for v1.1 and v1.2 databases are exported to CSV files. Information about assignment of genomes from v1.1 species to v1.2 species during v1.2 -> v1.2 migration is exported in its own file and also used to annotate species tables. Also reads v1.1 overlap components from hdf5 file from `200727-find-overlaps` experiment and outputs in simpler JSON format.

Outputs reference v1.1 and v1.2 species by index, this corresponds to their ordering in the two exported tables. All indices start from 1 for use with Julia.


### 210317-find-identical-genomes

This notebook identifies groups of identical genomes (zero Jaccard distance) and chooses one to keep from each group and marks the rest for deletion. Also identifies species which need to be removed entirely because they will have only one genome left.
This isn't technically overlap removal but wanted to do it first before doing a deep dive into species-level distance matrices.

#### Results

901 groups were found in 123 species. The large majority were just pairs of genomes, groups larger than 10 mostly confined to S. pneumoniae, S. enterica, M. tuberculosis and other species with large nubers of genomes.

22 species will be left with one genome and will need to be removed. All had only 2 or 3 genomes.


### 210323-find-species-overlaps

Finds all overlaps between species in v1.2 database.

#### Results

Goal was to separate species with overlaps into separate components to be individually resolved
later, this was made impossible by several species which had "outgoing" overlaps to a very large #
of other species (which would result in only a single connected component containing almost all
species). The worst was Perchlorococcus marinus, with 1371 outgoing overlaps (nearly all other
species). There were another 2 species with outgoing counts in the hundreds, and 8 with at least 10.

These problem species probably include a few outlier genomes that artificially inflate their "max
intra" scores, causing an extreme number of overlaps. Removing these outliers should cause the
number of outgoing overlaps to drop significantly for these species.


### 210327-fix-problem-species

Attempt to fix species causing a large number of overlaps in previous experiment. Decicded to focus on species with overlaps to species from other genera. After fixing these some "problematic" species may remain, but should still be able to group all overlapping species into separate components.

#### Results

Identified 8 species with outgoing overlaps to other genera. Fixed using a combination of deleting outliers, manually lowering thresholds, and splitting into subgroups.


### 210328-compile-edits

Merges genome removals from `210317-find-identical-genomes` and other edits in `210327-fix-problem-species` into genus/species lists from `210303-format-data`. Also removes species with less than 2 genomes remaining after removals. Outputs unified list of taxa and genome assignments.


## Output


* Intermediate
  * `210303-format-data`
    * `genomes-v1.1.csv`: All genomes in v1.1 database (superset of all genomes in 1.2 databawe), annotated with species indices for both v1.1 and v1.2 databases. Order of genomes in table corresponds to row/columns of pairwise distance matrix caluclated in 200xx. v1.2 index of 0 means that genome was removed.
    * `species-v1.1.csv`: Summary of all species in v1.1 database. Other files which reference a 1.1 species by index use the order in this table.
      * `migration_dst_idxs1`: Indices of all v1.2 species this species' genomes were assigned to.
      * `migration_ndropped`: Number of genomes removed entirely during migration.
      * `migration_single_dst`: If this species' genomes were all reassigned to a single v1.2 species (excluding those removed).
      * `migration_1to1`: If `migration_single_dst` and the 1.2 destination species' genomes all came from this species.
      * `migration_identical`: If `migration_1to1` and no genomes were dropped (this species and its 1.2 destination contain exactly the same genomes).
    * `species-v1.2.csv`: Summary of all species in v1.2 database. Other files which reference a 1.2 species by index use the order in this table.
      * `migration_src_idxs1`: Indices of all v1.1 species this species' genomes came from.
      * `migration_single_src`: If all this species' genomes came from the same v1.1 species.
      * `migration_1to1`: If `migration_single_src` and the 1.1 source species' genomes weren't assigned to any other species.
      * `migration_identical`: If `migration_1to1` and no genomes from the v1.1 source species were dropped (this species and its 1.1 source contain exactly the same genomes).
    * `genera-v1.2.csv`: Summary of all genera in v1.2 database.
    * `migration-genome-reassignment-counts.csv`: counts of v1.1 genomes grouped by source (v1.1) and destination (v1.2) migration species index. A destination index of 0 means the genomes were deleted.
    * `overlap-components-v1.1.json`: (NOTE 210312: these are invalid due to a mistake in the referenced experiment). List of v1.1 species indices for each overlap component found in `200727-find-overlaps`. Components appear in same order as they are numbered in the reports from that experiment.
  * `210317-find-identical-genomes/`
    * `identical-genome-groups.json`: Groups of identical genomes and their exemplars, as genome indices starting from one.
  * `210323-find-species-overlaps/`
    * `genomes-addendum.csv`: Extra columns to add to `210303-format-data/genomes-v1.1.csv`.
    * `species-addendum.csv`: Extra columns to add to `210303-format-data/species-v1.2.csv`.
    * `species-overlaps.csv`: List of all species overlaps as directed `src => dst` pairs.
  * `210327-fix-problem-species/`
    * `problem-species.json`: Data on all "problem species", including all outgoing genus-genus overlaps.
	* `fixes.json`: Description of fixes applied to remove overlaps from species.
  * `210328-compile-edits/`
    * `taxa.csv`: Table listing all taxa in database after applied updates (genera, species, and any species subgroups manually added). Column descriptions:
      * `id`: Unique ID integer ID. This is equal to the database ID for all tax present in the v1.2 database.
      * `manual_threshold`: Manually set thresholds for certain taxa, others are NaN.
      * `is_leaf`: if taxon has no children.
    * `deleted-taxa-db-ids.json`: Database IDs of deleted taxa from v1.2.
    * `genome-taxon-assignments.json`: ID of taxon assigned to each genome. Removed genomes are zero. Simple integer array, order corresponds to `../210303-format-data/genomes-v1.1.csv`.

* Processed
  * `210317-find-identical-genomes/`
    * `210317-identical-genome-groups.csv`: Info on identical genome groups, one group per line.
    * `210317-identical-genome-groups-by-species.csv`: Per-species summaries of identical genome groups.
      * `sp_needs_remove`: If this species needs to be removed entirely because there will be only one genome left.

* Reports
  * `210327-fix-problem-species/`
    * `*.html`: Plotly cluster maps for all problem species.
