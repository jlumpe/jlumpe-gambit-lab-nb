# 211011 Gambit ANI additional genomes

This experiment is an extension of `210902-mash-Escherichia-genomes` to additional genome sets.

Will compare results to FastANI only, not Mash.

The new genome sets are:

* `konstaninidis_2005` - 70 genomes from across the bacterial kingdom
* `snkitkin_2012` - 20 genomes from a Klebsiella pneumoniae subsp. pneumoniae outbreak, very similar.
* `200726_gold_standard` - 80 "gold standard" genomes direct from public health labs, previously
  used for testing GAMBIT's taxonomy identification. This was added to the experiment after the
  first two.

Starting data for these genome sets are found in their folders in `data/external/`. The data set
from the previous experiment is included in analysis notebooks in this experiment with the key
`ondov_2016`.


## Notebooks

### 211011-get-genomes-list

Combine genome lists from both sets into common table, find assembly UIDs from accession nos and
download ESummary data for each.


### 211011-get-genome-seqs

Downloads sequences for all genomes from NCBI. Saved to `tmp/` directory.


### 211012-fastani

Calculates full pairwise FastANI scores for the `konstaninidis_2005` and `snkitkin_2012` data sets.
Parses result files and saves in HDF5 format.

#### Results

Only about 7% of pairs in the `konstaninidis_2005` data set had reported scores (which happens when
the ANI is under about 80%), this is somewhat expected because the genomes in this set are so
divergent.


### 211012-gambit

Create GAMBIT signatures and calculate pairwise distances for the `konstaninidis_2005` and
`snkitkin_2012` data sets with the 192 KmerSpecs used in the previous experiment.


### 211015-fastani-gsg

Calculates FastANI scores for the `200726_gold_standard` data set using the same method as the last
two.

#### Results

Similar to the `konstaninidis-2005` data set, FastANI only reported scores for about 8% of pairs.
This makes sense because the genomes in this data set are also very diverse.


### 211015-gambit-gsg

Calculates GAMBIT signatures and pairwise distances for the `200726_gold_standard` data set using
the same method as the last two.



## Output

* `data/processed/211011-gambit-ani-additional-genomes/`
  * `211011-get-genomes-list/`
    * `211011-gambit-ani-additional-genomes.csv` - Table of genomes to be used in this experiment,
      with assembly accession nos and UIDs.

* `data/intermediate/211011-gambit-ani-additional-genomes/`
  * `211012-fastani/`
    * `*.h5` - FastANI results for first two data sets.
  * `211012-gambit/`
    * `*.h5` - GAMBIT pairwise distances for first two data sets.
  * `211015-fastani-gsg/`
    * `*.h5` - FastANI results for the `200726_gold_standard` data set.
  * `211015-gambit-gsg/`
    * `*.h5` - GAMBIT pairwise distances for the `200726_gold_standard` data set.

