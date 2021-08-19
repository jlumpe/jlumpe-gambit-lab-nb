# testdb_210818

This is a reference database created from artificial/synthetic genomes, to be used for testing.
It is an improved version of `testdb_210126`. Includes a set of query genomes.


## Details

Used similar process as `testdb_210126`, used smaller reference and query genome size (5kb from 100kb)
to cut down on file size. Used k-mer parameters AT/6 instead of ATG/8.

Database was verified to be clear of overlaps between reference taxa.


## Files

### testdb_210818-genomes.db

SQLite reference genome database.


### testdb_210818-signatures.h5

Signatures for reference genomes in HDF5 format, using AT/6 spec.


### testdb_210818-query-seqs.tar.gz

Tarball containing sequences for query genomes in FASTA format.
`queries.csv` lists all query sequences and the taxa they are expected to be classified as,
as well as primary/closest matching genomes and whether there should be any classifier warnings.
Also includes signatures of query genomes in HDF5 format.


### testdb_210818-supplemental.tar.gz

Additional supplemental data, just for archival purposes.

