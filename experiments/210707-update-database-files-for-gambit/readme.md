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

