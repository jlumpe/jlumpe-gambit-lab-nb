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


### 210717-calculate-signatures

Downloads sequences using URLs determined in last experiment and calculates their k-mer signatures.
Saves signatures as individual `.npy` files in the `tmp/` subdirectory.


### 210718-create-signatures-file

Compiles signatures calculated in last experiment into single signatures file (old binary format).
Uses same order, IDs (refseq accs), and metadata (except creation date attribute) as old file.
Metadata JSON was obtained from cell output in `200727-find-overlaps/200727-calculate-pw-distances`
notebook.

Resulting file added to GC storage but not VC.


### 210718-validate-signatures

Validates calculated signatures by re-calculating a subset of all pairwise distances and comparing
to those calculated in `200727-find-overlaps/200727-calculate-pw-distances` notebook.



## Output

*  `data/intermediate/210717-recreate-midas-db-1.1-signatures`
  * `210717-find-sequence-urls/`
    * `url-data.json`: Sequence URLs for all genomes in signature file to recreate. Appear in same
      order.


### Not in version control

* `200727-find-overlaps/200727-calculate-pw-distances.gz`
