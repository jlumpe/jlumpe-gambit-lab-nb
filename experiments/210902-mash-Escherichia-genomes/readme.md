# 210902 Mash Escherichia genomes

This experiment will download the 500 Escherichia genomes used in the Mash paper to compare their
similarity score to ANI. I will attempt to recreate that analysis and compare the results to the
GAMBIT similarity using various parameters.


## Notebooks

### 210902-get-genomes

Extracts information from the `ids.txt` file in the data archive provided by Mash (see [supporting
data](https://mash.readthedocs.io/en/latest/data.html) section of documentation) and attempts to
download the genome sequences from the NCBI assembly database.

#### Results

Only about half of the Mash IDs had an assembly accession, was able to find most of the rest through
use of the Entrez Elink and ESearch tools. Could not find an NCBI assembly database entry for 8 of
the 500 genomes. Downloaded all genomic data to temporary directory.


### 210902-mash-distances

Calculates pairwise distances for all genomes using the Mash tool with a variety of parameter
combinations. Uses sketch sizes 500, 1,000, 5,000, and 10,000 and k in `11:2:31`.


### 210904-fastani

Estimates ANI for all genome pairs using the FastANI tool. Every pair of distinct genomes is run
twice, with both assignments of the genomes as query or reference (this is not symmetric). Uses
default parameters.


### 210917-gambit

Creates gambit signatures for all genomes for 192 different k-mer specs, and calculates pairwise
distances for each.

Parameters used are the Cartesian product of the following:
* 8 "base prefixes" of length 7. The first is our standard "ATGAC" plus another two nucleotides,
  the other seven are random.
* Prefix lengths from 4 to 7. Actual prefixes are the first n nucleotides of the 8 base versions.
* Odd values of k from 7 to 17.

The following are the 8 base prefixes:
* ATGACTG
* ATCATTT
* TCTCGAT
* GAAAGCG
* TTGACCC
* CACATAT
* CGTTAGT
* ACTCTTG


## Output

* `data/intermediate/210902-mash-Escherichia-genomes/`
  * `210902-get-genomes/`
    * `genomes.csv` - Table of genomes from NCBI assembly database to be used in this experiment.
  * `210902-mash-distances/`
    * `mash-distances.h5` - HDF5 file containing pairwise Mash distances for all genomes for
      multiple parameter combinations.
  * `210904-fastani/`
    * `ani-matrix.h5` - All FastANI results in matrix format with references in rows and queries in columns.
    * `ani-pairwise.h5` - .
	  * `*_r1q2` - Statistic with genome 1 as reference and genome 2 as query.
	  * `*_r2q1` - Statistic with genome 2 as reference and genome 1 as query.
	  * `*_mean` - Average of the two.
  * `210917-gambit/`
    * `params.csv` - parameter values used to generate the 192 k-mer specs used. Order of rows
      corresponds order of parameter dimension of arrays in the next file.
    * `pw-dists.h5`
	  * `genome1` - Index of first genome for pw comparison (1-based).
	  * `genome2` - Index of second genome for pw comparison (1-based).
	  * `pw_dists` - Pairwise distances. Parameter values in rows, pairs in columns.
	  * `kmer_counts` - K-mer counts in signatures. Parameter values in rows, genomes in columns.

* `data/processed/210902-mash-Escherichia-genomes/`
  * `210902-get-genomes/`
    * `210902-mash-genomes.csv` - data parsed out of Mash `ids.txt` file plus additional information
	  derived from Entrez tools.
