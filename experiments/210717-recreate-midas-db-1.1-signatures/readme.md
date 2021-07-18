# 210717 Recreate MIDAS DB 1.1 Signatures

All overlap resolution notebooks for the past year have used a genomic pairwise distance matrix
calculated in the notebook `210727-find-overlaps/210727-calculate-pw-distances`. This used the
signature file `refseq_curated_1.1beta_200604.midas-signatures.gz`, which I can no longer find on
either my computer or the Google Cloud storage bucket for the project. I believe it was created
in the `build-v1-database/4-calc-signatures` notebook in the `midas-notebooks-2019` repo. I will
need to re-create it.


## Notebooks

### 210717-find-sequence-urls

Extracts sequence URLs from the genome metadata in the MIDAS 1.1 database (v1 software format),
adjusts to same order as the genomes should have appeared in the signature file, and exports to JSON.



## Output

*  `data/intermediate/210717-recreate-midas-db-1.1-signatures`
  * `210717-find-sequence-urls/`
    * `url-data.json`: Sequence URLs for all genomes in signature file to recreate. Appear in same
      order.
