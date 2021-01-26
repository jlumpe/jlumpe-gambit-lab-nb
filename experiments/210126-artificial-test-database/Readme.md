# 210126 Artificial test database

This experiment creates a database containing synthetic/artificial reference genomes, to be used for testing.
See file `output/testdb_210126_readme.md` for a more detailed description of how the database was created.


## Notebooks


### 210126-create-test-database

Creates reference genome sequences grouped into hierarchical taxa, along with set of query sequences.
Outputs SQL database file, signatures file for reference genomes (using kpsec ATG/8),


### 210126-verify-query-results

Runs queries using query sequences and reference database created in previous notebook and verifies results.


### package.sh

Packages reference and query sequences into tarballs for archiving/distribution.


## Output

Final output files to be stored in project archive are written to `output/`.
See `output/testdb_210126_readme.md` for descriptions.

