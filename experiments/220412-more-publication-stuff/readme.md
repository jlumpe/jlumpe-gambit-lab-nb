# 220412 More publication stuff


Some more notebooks for finishing up the initial publication.


## Notebooks


### 220412-recreate-old-fig3-1

Recreation of old plot created as initial example version of figure 3 in the paper, which only uses
a single example genome from Set 3. Originally from `200811-fastq-kmer-counts-basic-comparison`,
adapted to newest GAMBIT version.

Uses same file as in original, `16AC1611139-CAP_S14_L001_R1_001`.

#### Results

Some of the numbers are very slightly different from the original for some reason, but close enough.
Plots look identical.


### 220412-recreate-old-fig3-2

Same as previous, but using file `17AC0012455-1A_S1_L001_R1_001` which had poor performance in
latest draft of figure 3 analysis.

#### Results

Poor precision and recall.


### 220412-recreate-old-fig3-3

Same as previous, but using file `19AC0011209PEA_S8_L001_R1_001` which had poor performance in
latest draft of figure 3 analysis.

#### Results

Very similar to `17AC0012455-1A_S1_L001_R1_001`.


### 220412-set2-taxonomy

Gets NCBI taxonomy tree for genomes in set 2. Find KPCOFGS lineage for each.



## Comments


### Figure 3 files

Best parameter values for each file:

| File                | Min PHRED | Min Count | Precision | Recall | Jaccard | Rank | Percentile |
|---------------------+-----------+-----------+-----------+--------+---------+------+------------|
| 16AC1611139-CAP_S14 |        12 |         2 |     0.995 |  0.997 |   0.006 |   13 |       0.15 |
| 17AC0012455-1A_S1   |        11 |         4 |     0.964 |  0.876 |   0.150 |   77 |       0.98 |
| 19AC0011209PEA_S8   |        17 |         3 |     0.903 |  0.891 |   0.185 |   78 |       1.00 |



## Output

* `data/processed/220412/`
  * `220412-set2-taxonomy/`
    * `220412-set2-lineages.csv` - KPCOFGS names for all genomes.
	* `220412-set-taxa.csv` - Table of taxa in other table.
