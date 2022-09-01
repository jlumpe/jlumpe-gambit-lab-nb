# 201027-database-v2-midas-2.2-migration

This is a one-notebook experiment. Purpose is to test alembic migration script for revision
d961d0698083 in upcoming midas release 2.2. This revision deletes some columns I deemed
unnecessary and migrates their data into the "extra" JSON data column. Because the data
migration part of the script is complicated and I haven't done it before, this notebook
runs the migration in a copy of the v2 database and does some basic tests to ensure the
data was moved correctly.

This is using the v2 database file made in 2017 or so, which we probably won't be
using in the future but I want to make sure it will be accessible with the new
schema just in case.

Data migration for downgrade to previous revision is implemented in the script, but is
not tested in this notebook (I don't think I'm likely to use it).


## Output

No output from this experiment saved in this repo's directory.
