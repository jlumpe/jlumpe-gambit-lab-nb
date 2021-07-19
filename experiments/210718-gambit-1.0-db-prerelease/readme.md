# 210718 Gambit 1.0 DB prerelease

This experiment is going to hastily assemble a re-release version of the GAMBIT 1.0 database just to
get it out there and get Kevin working with it as soon as possible. I will follow up with a "proper"
1.0 release with more careful tests and check for self-consistency.


## Notebooks

### 210718-compile-edits

Starting from the final taxonomy table resulting from `210401-database-v2-fix-species-overlaps`,
adds in changes from `210428-v1.2-fix-remaining-overlaps` (genome deletions in
`210710-remove-min-inter-outliers`), creates merged Escherichia/Shigella taxon, and assigns unique
values for the `key` column. This will be the full list of taxa in the created database.


### 210718-calculate-additional-data

Calculates additional per-taxon data to assist in further notebooks, as well as leaf pairwise distances.


### 210719-set-thresholds

Set final classification thresholds for all taxa. The "base threshold" is either the manually-set
threshold for the taxon based on previous experiments, or otherwise the taxon's diameter. The
"final threshold" is the lesser of either this value or the min-inter value minus a "margin", which
here is set to 5%. The "coverage" statistic is the fraction of intra-taxon distances less than the
final threshold.

Output a table with `"base_threshold"`, `"final_threshold"`, and `"coverage"` columns.

#### Results

* 3 taxa ended up with thresholds set by the min-inter distance minus the margin which were less
  than their previous manually-set thresholds, but only slightly.
* Coverage was pretty low for some taxa, with 14 at less than 20. The worst were Prevotella at 4%
  and Streptomyces at 8%. Probably fine for now but will look into it more when creating the
  non-beta version.


### 210719-build-genome-database

Create the genome database SQLite3 file, using genomes from previous database (MIDAS 1.2a) (minus
those removed from in version) and taxonomy information created in this experiment.

#### Results

48224 genomes in final database. Database file has small size (16MB) due to NCBI data of genomes
and taxa not being included.


### 210719-create-signatures-file

Create HDF5 signatures file for genomes in database. Derived from
`refseq_curated-1.1beta-210718.midas-signatures`, filtered to only include genomes in this version
of the database and reordered by taxonomy assignment.


## Output

* `data/intermediate/210718-gambit-1.0-db-prerelease/`
  * `210718-compile-edits/`
    * `taxa.csv` - table containing data for all taxa to be included in database, aside from
      threshold values.
  * `210718-calculate-additional-data/`
    * `taxa.arrow` - taxa table with additional data added.
    * `leaf-data.h5` - HDF5 file containing pairwise leaf distances.
  * `210719-set-thresholds/`
    * `thresholds.csv` - table containing final thresholds for all taxa.
  * `210719-build-genome-database/`
    * `old-tid-to-new.json` - Mapping from old taxon ID values (used by previous few experiments) to
	  primary key values of taxa in output database.


### Not in version control

* `gambit-genomes-1.0b1-210719.db` - SQLite3 genomes database `gambit/refseq-curated` `1.0b1`
* `gambit-signatures-1.0b1-210719.h5` - HDF5 signatures `gambit/refseq-curated` `1.0b1`
