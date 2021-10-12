# 211011 Gambit ANI additional genomes

This experiment is an extension of `210902-mash-Escherichia-genomes` to additional genome sets.

Will compare results to FastANI only, not Mash.

The new genome sets are:

* `konstaninidis-2005` - 90 genomes from across the bacterial kingdom
* `snkitkin-2012` - 20 genomes from a Klebsiella pneumoniae subsp. pneumoniae outbreak, very similar.

Starting data for these genome sets are found in their folders in `data/external/`.


## Notebooks

### 211011-get-genomes-list

Combine genome lists from both sets into common table, find assembly UIDs from accession nos and
download ESummary data for each.


## Output

* `data/processed/211011-gambit-ani-additional-genomes/`
  * `211011-get-genomes-list/`
    * `211011-gambit-ani-additional-genomes.csv` - Table of genomes to be used in this experiment,
      with assembly accession nos and UIDs.

