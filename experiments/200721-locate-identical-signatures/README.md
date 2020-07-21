# 200721 Locate Identical Signatures

## Purpose

While working with the signatures calculated for the 2020 rebuild of the v1 database (using the current unverified "beta" version of the rebuild signatures created on 200604) I noticed that there were apparently pairs of signatures that were exactly identical to each other. The purpose of this notebook is to find all such groups of genomes with identical signatures.


## Results

There are 901 total sets of identical signatures in the database. All are specific to only one species. The majority are only pairs, only 29 groups with size > 10. Largest is 135 (Streptococcus	pneumoniae, out of 7099 total in species).

If we are to choose one representative genome from each group and remove the rest from the database, a total of 2213 genomes would need to be removed.
There are 22 species with 2-3 genomes which are all identical to each other. If we require that every species needs at least 2 distinct genomes, these species should be removed from the database entirely.