# 120303 Database v1.2 overlaps


TODO purpose



## Notebooks

### 120303-format-data

Reads relevant data for this experiment from different sources, performs some pre-processing, and saves them to CSV and JSON files for easy use from Julia. Genome and taxonomy info for v1.1 and v1.2 databases are exported to CSV files. Information about assignment of genomes from v1.1 species to v1.2 species during v1.2 -> v1.2 migration is exported in its own file and also used to annotate species tables. Also reads v1.1 overlap components from hdf5 file from `200727-find-overlaps` experiment and outputs in simpler JSON format.

Outputs reference v1.1 and v1.2 species by index, this corresponds to their ordering in the two exported tables. All indices start from 1 for use with Julia.




## Output


* Intermediate
  * `120303-format-data`
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
