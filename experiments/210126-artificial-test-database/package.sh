#!/bin/bash

# Script to package up experiment's output files into tarballs for storage/distribution

set -e

DATESTR="210126"
DBNAME="testdb_$DATESTR"


# Reference sequences
(set -x; tar -czf "output/${DBNAME}_reference_seqs.tar.gz" -C tmp genomes.csv taxa.csv -C reference_sequences .)

# Query sequences
(set -x; tar -czf "output/${DBNAME}_query_seqs.tar.gz" -C tmp queries.csv -C query_sequences .)
