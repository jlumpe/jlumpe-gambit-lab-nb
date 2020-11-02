# 201031-database-v1.1-software-version-migration

The purpose of this experiment is to migrate the information in the v1.1 (beta) database (created 200525) from version 1 to version 2 of the core MIDAS library database schema.


## Notebooks


### 201031-migrate-genomes

Creates a fresh database using schema from latest `midas` package version `2.2.0` and migrates all genome entries from archive file of v1.1 (beta) database. Does not attempt to create entries in new `taxa` table from the `gb_tax_summary` attribute of genomes in the archive file, instead just records the taxonomy IDs of all genomes so that the up-to-date taxonomy information can be downloaded in the next notebook.

#### Output

* `db.sqlite` file in working directory, containing base genome data in `v2.2.0` schema. Taxonomy and additional genome annotation data to be added by following notebooks.
* `tmp/genome_taxids.json` - list of NCBI taxonomy IDs for all genomes added to new database file.