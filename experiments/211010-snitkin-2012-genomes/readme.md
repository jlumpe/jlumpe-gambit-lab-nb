# 211010 Snitkin-2012 genomes

Looks up NCBI data for genomes in Snitkin-2012 paper.


## Notebooks

### 211010-snitkin-2012-genomes

Starts from the nuccore accession nos provided in paper, makes Entrez queries to find corresponding
accession entries. Downloads nuccore and assembly ESummary data for each.

Two nuccore entries (UIDs 397353112 and 397390985) were marked as "dead" and had no ELink results to
assembly. Was able to get unique links to assembly from their corresponding biosamples instead. This
method yielded the same results as a direct link for the non-dead genomes.



### Output

* `data-processed/211010-snitkin-2012-genomes/`
  * `211010-snitkin-2012-genomes/`
    * `211010-snitkin-2012-genomes.csv` - Nuccore and assembly UIDs and accession nos for each genome.
    * `211010-snitkin-2012-nuccore-esummary-data.csv` - Select ESummary data for nuccore entry of
      each genome.

