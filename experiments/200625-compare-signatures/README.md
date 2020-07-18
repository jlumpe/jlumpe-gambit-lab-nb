# 200625 Compare old/new genome signatures

## Purpose

This is a sanity check to ensure that the signatures calculated for the 2020 rebuild of the v1 database (designated v1.1) match those calculated in 2017. The current unverified "beta" version of the rebuild signatures was created on 200604. There was no file I could find containing the signatures for original v1 database (signature file format was introduced for v2 of library) but I found one for the v2 library, which should work just as well for the sanity check.


## Results

Genomes were matched between the files by accession number. There were 50564 common genomes between the two files, 188/50752 of the new file and 23596/74160 of the old file were not matched (v2 database was considerably larger than v1).

Of the 50564 common genomes, only one had different signatures for the two sets ([GCF_000230875.1](https://www.ncbi.nlm.nih.gov/assembly/GCF_000230875.1/), Salmonella enterica). The new signature had 4 additional kmers in addition to the 10629 in the old one, for a Jaccard distance of 0.00038. I don't consider this significant, it can be explained by a slight update to the sequence on Genbank between then and now.