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


### 211015-combine-data

Combines GAMBIT and FastANI data for the data sets in this experiment, as well as results from the
`210902-mash-Escherichia-genomes` experiment using the `ondov_2016` genome set, into a single common
format. Also calculates Pearson, Spearman, and Kendall Tau correlation statistics between GAMBIT
distances and ANI, for each genome set and parameter set combination. Saves entire data set in a
NETCDF file. Analysis left for next notebook.


### 211016-additional-genome-stats

Extracts additional genome assembly information from Entrez ESummary data for all NCBI genomes.
Also calculates n50 and l50 stats for all assemblies, these matched NCBI data where applicable.


### 211016-basic-plots

Makes some basic plots based on the output of the last two notebooks. Save two of them to "reports"
directory.

#### Results

Spearman correlation with ANI for standard parameter set is very good and close to the best set of
parameters, in all but `snitkin_2012`. Correlation seems to break down in `snitkin_2012` where
similarity is very high. Will investigate more in the future.

Assembly quality in `200726_gold_standard` is much poorer than the other three data sets (in all
statistics), as expected because they come directory from a public health setting. That probably
makes makes it a good set to include in analysis and paper. The exception is two genomes
`18AC0018936-1_S12` and `19AC0002349B1_S10` which have very low total size (definitely much less
than what the genome should be). These should probably be excluded from further analysis.

Will need to further investigate genome pairs where FastANI did not report a score.

Kendall tau statistic is very similar to spearman, seems to be no need to use it.


### 211019-get-taxonomy-tree

Fetches taxonomy data for all NCBI genomes in all data sets, along with ancestors of all these taxa.
Will compare against hierarchical clustering trees in next experiment.



## Output

* `data/processed/211011-gambit-ani-additional-genomes/`
  * `211011-get-genomes-list/`
    * `211011-gambit-ani-additional-genomes.csv` - Table of genomes to be used in this experiment,
      with assembly accession nos and UIDs.
  * `211015-combine-data/`
    * `211015-gambit-ani-genomes.csv` - Table of genomes in all data sets.
  * `211016-additional-genome-stats/`
    * `211016-ncbi-assembly-meta.csv` - Parsed and formatted contents of "meta" field in ESummary
      data for all NCBI genomes.
	* `211016-assembly-stats.csv` - Basic assembly stats (n50 and l50) for all genomes.

* `data/intermediate/211011-gambit-ani-additional-genomes/`
  * `211012-fastani/`
    * `*.h5` - FastANI results for first two data sets.
  * `211012-gambit/`
    * `*.h5` - GAMBIT pairwise distances for first two data sets.
  * `211015-fastani-gsg/`
    * `*.h5` - FastANI results for the `200726_gold_standard` data set.
  * `211015-gambit-gsg/`
    * `*.h5` - GAMBIT pairwise distances for the `200726_gold_standard` data set.
  * `211015-combine-data/`
    * `data.nc` - GAMBIT distance vs FastANI comparison genome sets in this experiment plus
	  ondov-2016, put into common format. File format is NETCDF4.
  * `211019-get-taxonomy-tree/`
    * `genome-taxids.csv` - maps genomes in this experiment to NCBI taxids.
    * `taxa.csv` - Basic info for taxa in previous file plus their ancestors.

* `reports/211011-gambit-ani-additional-genomes/`
  * `*.png` - Selected plots from `211016-basic-plots`.

