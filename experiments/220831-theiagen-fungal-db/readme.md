# 220831-theiagen-fungal-db

Assist Theiagen in developing a basic GAMBIT database for fungal pathogens.

The final database files are:

* `data-processed/220916_1_create-db/220916-theiagen-candida-test.db`
* `data-processed/220916_2-finalize-signatures/220916-theiagen-candida-test.h5`


## Notebooks

### 220831_1-download-genomes

Download esummary data and FASTA sequences for all genomes.


### 220831_2-signatures-and-dists

Create GAMBIT signatures for all genomes and calculate pairwise distances.


### 220831_3-find-diameters

Calculate diameters and min-inter distances for all species.


### 220912-download-taxa

Download NCBI taxonomy ESummary data for all genomes.


### 220916_1-create-db

Create sqlite database file with species-level taxa only, including distance thresholds from
`220831_3-find-diameters`.


### 220916_2-finalize-signatures

Add proper metadata to signatures file.
