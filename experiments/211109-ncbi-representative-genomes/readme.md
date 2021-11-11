# 211109 NCBI representative genomes

This project will download all bacterial genomes from NCBI labeled as "Reference" or
"Representative", for use in validation of method or publication.


## Notebooks

### 211111-find-genomes

Performs an ESearch query for NCBI assembly DB entries matching desired criteria, downloads ESummary
info for all.

#### Results

Found 14388 genomes.


## Output

* `data/processed/211109-ncbi-representative-genomes/`

* `data/intermediate/211109-ncbi-representative-genomes/`
  * `211111-find-genomes/`
    * `assembly-summaries.tar.gz` - tarball of all assembly summaries in JSON format.

