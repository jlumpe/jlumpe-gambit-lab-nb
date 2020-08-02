# 200801 Gold standard queries

This notebook will simply run a set of "gold standard" queries against the newest version of the rebuit v1 database. This is a new set of 80 FASTA query files received from David on 200726 that are meant to be used as the definitive test of integrity/accuracy of every new MIDAS database/installation of a database. I do not know the expected results of these queries.

The following database data was used:
* The "v1.1 beta" version of the v1 database rebuild created 200525
* Signatures (ATGAC/11) for above database calculated 200604
* Original species thresholds from 160901
* Original genus thresholds, all set at 02.


## Results

12 of the 80 query sequences did not have a predicted species due to the top scores being too low, 5 did not have a predicted genus.


## Output

* `data/processed/200801-gold-standard-queries/200801-refseq-curated-1.1_beta-gold-standard-query-results.csv` - query results, formatted as from `midas_cli`.