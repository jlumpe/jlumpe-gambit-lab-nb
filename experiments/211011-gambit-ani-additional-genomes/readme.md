# 211011 Gambit ANI additional genomes

This experiment is an extension of `210902-mash-Escherichia-genomes` to additional genome sets.

Will compare results to FastANI only, not Mash.

The new genome sets are:

* `konstaninidis-2005` - 70 genomes from across the bacterial kingdom
* `snkitkin-2012` - 20 genomes from a Klebsiella pneumoniae subsp. pneumoniae outbreak, very similar.

Starting data for these genome sets are found in their folders in `data/external/`.


## Notebooks

### 211011-get-genomes-list

Combine genome lists from both sets into common table, find assembly UIDs from accession nos and
download ESummary data for each.


### 211011-get-genome-seqs

Downloads sequences for all genomes from NCBI. Saved to `tmp/` directory.


### 211012-fastani

Calculates full pairwise FastANI scores for both data sets. Parses result files and saves in HDF5
format.

#### Results

Only about 7% of pairs in the `konstaninidis-2005` data set had reported scores (which happens when
the ANI is under about 80%), this is somewhat expected because the genomes in this set are so
divergent.


## Output

* `data/processed/211011-gambit-ani-additional-genomes/`
  * `211011-get-genomes-list/`
    * `211011-gambit-ani-additional-genomes.csv` - Table of genomes to be used in this experiment,
      with assembly accession nos and UIDs.

* `data/intermediate/211011-gambit-ani-additional-genomes/`
  * `211012-fastani/`
    * `*.h5` - FastANI results for each data set.

