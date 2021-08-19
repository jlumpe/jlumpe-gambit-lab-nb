#!/bin/bash

# Script to package up additional output files into tarballs for archiving

set -xe

DBNAME="testdb_210818"

tar -czf "output/${DBNAME}-query-seqs.tar.gz" -C tmp query-seqs.csv query-signatures.h5 query-seqs/
tar -czf "output/${DBNAME}-supplemental.tar.gz" -C tmp ref-genomes.csv ref-genomes.fasta taxa.csv taxon-centers.fasta

