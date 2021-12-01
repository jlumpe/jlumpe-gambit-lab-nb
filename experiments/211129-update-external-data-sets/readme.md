# 211129 Update external data sets

Downloads some additional data for external data sets.


## Notebooks

### 211201-konstantinidis-2005

Fetches all NCBI taxonomy data for taxa assigned to Konstantinidis 2005 genomes and their ancestors.
Saves full data in JSON format along with important attributes in table. Also creates updates genome
table with information from assembly ESummary data.



## Output

* `data/intermediate/211129-update-external-data-sets/`
  * `211201-konstantinidis-2005/`
    * `211201-konstantinidis-2005-taxa.json.gz` - Full taxonomy tree for Konstantinidis 2005 genome
      set. Originally XML downloaded from NCBI taxonomy DB, converted to JSON format.

* `data/processed/211129-update-external-data-sets/`
  * `211201-konstantinidis-2005/`
    * `211201-konstantinidis-2005-genomes.csv` - Table of all genomes containing relevant info from
      NCBI assembly ESummary data.
    * `211201-konstantinidis-2005-taxa.csv` - Table of basic information on all taxa in tree
      downloaded in this experiment.

