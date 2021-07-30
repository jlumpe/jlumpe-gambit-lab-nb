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


### 210730-validation

Performs query with =200726-gold-standard-seqs= validation data set and saves results.

#### Results

Of 98 query sequences:

* 89 had a prediction at the species level or below
* 5 had a prediction at the genus level
* 4 had no prediction
* 3 Had an additional inconsistent prediction of genus rank


### 210730-validation-results-comparison

Compares results on validation data set from last experiment to an old spreadsheet of results found
in the Google Drive folder validation set came from
([link](https://drive.google.com/file/d/1Tx6w7hBZU94QGWu4E8T__YRGCqOiXDzE/view?usp=sharing)).
Don't know exactly when and how this was created (original upload date was 200617) but David seems
to have added some annotations to it.

Needed to manually match up new and old file names because there were some differences, was not
successful in all cases. 93 matches were made (6 I marked as questionable), 5 files were unmatched
in new set and 2 in old.

#### Results

All predictions were consistent with each other. Even when the new and/or old results had no species
prediction, the species of the closest genome matched in all but one case.

New predictions improved from genus to species in 7/10 cases and from nothing to genus in 2/6 cases.
There were no cases where the new predictions were less specific.



## Other files

* `data-input/`
  * `210730-validation-results-comparison/`
	* `original-results.csv` - Original results file, annotated by David.
	* `210730-validation-results-join.csv` - manually-created table to join old and new file names.


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
  * `210730-validation/`
    * `results.json` - Validation query results (different than standard JSON export format).

* `data/processed/210718-gambit-1.0-db-prerelease/`
  * `210730-validation/`
    * `210729-1.0b-validation-primary-matches.csv` - summary of closest matches for all query genomes.
    * `210729-1.0b-validation-alternate-matches.csv` - summary of 2nd match besides primary/closest,
	  for the 3 queries which have it.
    * `210729-1.0b-validation-unmatched-genus-info.csv` - information on genus/top-level taxon
	  of closest genome for all 4 queries where no call was made, to see how much the threshold was
	  missed by.
  * `210730-validation-results-comparison/`
    * `210730-1.0b-validation-results-comparison.csv` - merge of old and new result files, with
	  comparison information added.
	  * `file_match_ok` - Blank if I thought the match between the old and new file names was ok,
	    `"?"` if I thought it was questionable, `"new_only"` or `"old_only"` if no match made.
	  * `predictions_consistent` - If predicted taxa are consistent with each other. Compares at
	    species level if both made a species prediction, otherwise at genus level.
	  * `closest_genome_identical` - if the closest genomes are identical (same accession).
	  * `closest_genome_species_identical` - if the closest genomes are assigned to the same species.
	  * `new.*` - Columns from new results file.
	  * `old.*` - Columns from old results file. Jaccard scores have been altered to distances.


### Not in version control

* `gambit-genomes-1.0b1-210719.db` - SQLite3 genomes database `gambit/refseq-curated` `1.0b1`
* `gambit-signatures-1.0b1-210719.h5` - HDF5 signatures `gambit/refseq-curated` `1.0b1`
