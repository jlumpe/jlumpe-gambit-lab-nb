# testdb_210126

This is a reference database created from artificial/synthetic genomes, to be used for testing.
Includes a set of query genomes.


## Details

Generated using a random 100kb base sequence to use as the "center" of the root taxon,
creating a random number of mutations of this sequence to form the "centers" of subtaxa,
and then contuing this process recursively for 4 levels, decreasing the number of sites mutated at each level.
The sequences at the lowest level are used as the reference genomes.
This resulted in 878 reference genomes and 1/5/23/90 taxa at each level (the root is included as an explicit taxon).

Signatures are calculated using k-mer spec ATG/8 (as opposed to the ATGAC/11 spec used for the main refseq database).

Thresholds were set as the diameter of each taxon. Database was verified to be clear of overlaps.


## Files

### testdb_210126.db

SQL database containing genome set `midas/test/testdb_210126` and its genomes/taxa.


### testdb_210126.midas-signatures.gz

Signatures for reference genomes, using ATG/8 spec.


### testdb_210126_reference_seqs.tar.gz

Tarball containing sequences for reference genomes in FASTA format.
`genomes.csv` lists all reference genomes and their assigned taxa.
`taxa.csv` lists all taxa and their parents.


### testdb_210126_query_seqs.tar.gz

Tarball containing sequences for query genomes in FASTA format.
`queries.csv` lists all query sequences and the taxa they are expected to be classified as.
There is one sequence for each taxon (including root), plus an additional sequence that
should be classified as outside the root taxon.
