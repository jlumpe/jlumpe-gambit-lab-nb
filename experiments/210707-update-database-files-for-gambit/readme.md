# 210707 Update database files for gambit

The goal for this "experiment" is just to update/convert some database files to be compatible with the upcoming GAMBIT 0.1 public release.
This involves upgrading genome database files to the newest schema and converting the old binary signature file format into the new HDF5 format.

GAMBIT 0.1 has not been released yet, I will be using the latest and final MIDAS version 2.4 which is intended to be the same thing before the name change.

The databases to be converted are `testdb_210126` (which will continue to be used in automated tests for GAMBIT) and `refseq-curated 2.0`
(which I'll be using for testing just until I can finish up the final publishable version). Since `testdb_210126` will be used going forward
I will also change all references of "midas" (in database keys, etc.) to "gambit".


## Notebooks

### 210707-convert-signature-files

Convert signature files from old binary format to new HDF5-based format.

* `testdb_210126.midas-signatures` -> `testdb_210126-signatures-210707.h5`
  * Changed ID `midas/test/testdb_210126` -> `gambit/testdb_210126`
  * `id_attr = 'key'`
* `refseq_assemblies_ATGAC11_2_0.midas-signatures` -> `refseq_assemblies_ATGAC11-2.0-210707.h5`
  * `id_attr = 'refseq_acc'`


### 210707-upgrade-refseq-curated-2.0-4815-to-d961

Upgrades the most recent version of the refeq-curated 2.0 database file from schema revision 4815cccfb01b (midas version 2.1) to d961d0698083 (version 2.2).
This is a somewhat tricky upgrade because it involves deleting columns that contain large amounts of data, including `genomes.entrez_summary` and
`taxa.entrez_data`.

The original migration script was designed to migrate the data in the columns to be deleted by copying it into the "extra" columns of the associated tables.
This was running extremely slowly (still going after ~20 min), which I assumed was due to the large amounts of data being moved around. I edited the upgrade
script to disable the data migration aspect (update added to version control) and just drop this data completely. This extra data isn't necessary for the
functionality of the app and makes the database file much much bigger.

Running the updated script was still very slow and making the output file bigger instead of smaller. I realized this was probably because of fragmentation
issues. I solved it by copying the data to an in-memory database first, running the upgrade script on that, and then using the sqlite3 `VACUUM` command
to save an optimized copy to the disk.

Also fixed the issue where RefSeq accession nos were stored in the `genomes.genbank_acc` column instead of the `refseq_acc` column.

Will follow up with upgrade to most recent revision in next notbook.


* Input file: `refseq-curated-2.0-r2.db`
* Output file: `refseq-curated-2.0-r3-210707.db`


### 210707-upgrade-database-schemas

Upgrade most recent releases of both databases from revision d961d0698083 to latest revision c43540b80d50 and update metadata to describe new releases.

* `testdb_210126.db` -> `testdb_210126-r2-210707.db`
  * Removed `"midas/testdb_210126/"` prefix from genome keys.
* `refseq-curated-2.0-r3-210707.db` -> `refseq-curated-2.0-r4-210707.db`

