# 210818 Improved test database

The object of this experiment is to create an improved version of the `testdb_210126` test database,
which includes the following additional cases:

* Genomes assigned to non-leaf taxa
* Taxa with `report=False` and `threshold=None`
* Query genome files have multiple contigs
* Query which matches two inconsistent taxa
* Query where primary match is not equal to closest match

Additionally it will have much smaller file sizes, so it can be added to version control in the main GAMBIT repo.


## Notebooks

### 210818-create-database

Creates reference database, outputs genome SQL and signature files. Uses kpsec AT/6.


### 210818-create-query-seqs

Creates query sequences, one for each taxon in the database plus edge/special cases.


### 210819-verify-query-results

Runs queries using query sequences and reference database created in previous notebook and verifies results.


### package.sh

Packages additional files in `tmp/` into tarballs and saves to `output/`.


## Output

Final output files to be stored in project archive are written to `output/`.
See `output/testdb_210818_readme.md` for descriptions.
