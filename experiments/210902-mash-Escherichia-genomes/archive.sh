#!/bin/bash

# Archives data in ./tmp I want to keep and moves to data/

set -ex


# Destination files
DATA=$(realpatth ../../data)

GENOMES_FILE="$DATA/external/ondov-2016/210902-Escherichia-genomes.tar"
SUMMARIES_FILE="$DATA/external/ondov-2016/210902-Escherichia-genome-assembly-summaries.tar.gz"
GAMBIT_FILE="$(realpatth data-intermediate)/210917-gambit/gambit-signatures.tar.gz"

for file in "$GENOMES_FILE" "$SUMMARIES_FILE" "$GAMBIT_FILE"; do
	mkdir -p $(dirname "$file");
done


# Genomes (already individually zipped)
(cd tmp/genomes; tar -cf "$GENOMES_FILE" .)

# Assembly summaries
(cd tmp/assembly-summaries; tar -czf "$SUMMARIES_FILE" .)

# GAMBIT signatures
(cd tmp/gambit/signatures; tar -czf "$GAMBIT_FILE" .)
