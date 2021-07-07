# 210707 Update database files for gambit

The goal for this "experiment" is just to update/convert some database files to be compatible with the upcoming GAMBIT 0.1 public release.
This involves upgrading genome database files to the newest schema and converting the old binary signature file format into the new HDF5 format.

GAMBIT 0.1 has not been released yet, I will be using the latest and final MIDAS version 2.4 which is intended to be the same thing before the name change.

The databases to be converted are `testdb_210126` (which will continue to be used in automated tests for GAMBIT) and `refseq-curated 2.0`
(which I'll be using for testing just until I can finish up the final publishable version). Since `testdb_210126` will be used going forward
I will also change all references of "midas" (in database keys, etc.) to "gambit".

