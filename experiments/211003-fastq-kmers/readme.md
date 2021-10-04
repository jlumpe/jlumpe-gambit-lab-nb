# 211003 FASTQ kmers

This is an updated version of the `200811-fastq-kmer-counts` experiment where I find k-mers within
raw FASTQ reads and test what kind of count or quality filters are needed to get the same results as
the assembled genomes. I am using the `200726-gold-standard-seqs` genome set (without the additional
ones added in 2008xx).


## Notebooks

### 211003-find-kmers

Finds standard k-mer signatures of assembled FASTA files, then finds k-mers in each FASTQ file and
bins them by aggregated PHRED score. Used the following aggregation methods:

* Simple minimum of PHRED scores of all nucleotides in match (k-mer plus prefix).
* "PHRED sum" estimation of probability that at least one nucleotide in the match has an error,
  represented as a PHRED score.
  
Quality bins were from 0 to 30 in increments of one. `KmerSpec` was 11/ATGAC.

#### Results

Will analyze in following notebooks.
  
  
### 211003-additional-genome-stats

Calculates additional basic statistics from FASTA and FASTQ files relating only to number and size
of contigs/reads.


#### Results

The following assemblies have very low total size and n50:

| genome              | Size   | Contigs | N50  |
|---------------------|--------|---------|------|
| `18AC0018936-1_S12` | 200285 | 604     | 311  |
| `19AC0002349B1_S10` | 653490 | 775     | 2628 |


## Output

* `data/intermediate/211003-fastq-kmers/`
  * `211003-find-kmers/`
    * `assembled-signatures.h5` - Standard signatures calculated from assembly files.
    * `fastq-data.h5` - K-mer counts from FASTQ files.

* `data/processed/211003-fastq-kmers/`
  * `211003-additional-genome-stats/`
    * `211003-additional-genome-stats.csv` - additional basic summary statistics on genome
      assemblies and raw reads.
