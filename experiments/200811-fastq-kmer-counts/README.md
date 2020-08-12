# 200811 FASTQ kmer counts

This experiment aims to determine whether we can accurately read kmer signatures from raw sequencing reads in a FASTQ file without needing an assembled genome. I will be using the 2020 set of 80 "gold standard" genomes for this, which I have the raw reads for. According to David, this set is very diverse and so should be pretty representative of the range of queries we expect to run.


## Notebooks


### 200811-fastq-kmer-counts-basic-comparison

Picked a random genome from gold standard set to do a detailed exploratory analysis with. Started with kmer search in assembled genome keeping track of counts, 
followed with search in raw reads but filtered out low-quality matches by calculating a combined PHRED score for the 16-mer and thresholding at 10, 15, 20, and 25.
Ran additional filtering step by count threshold at 1, 2, 3, 4, 5, and 10. Calculated precision/recall for all threshold values.

#### Output

No output files, just some plots I forwarded to David.

#### Results

Results are preliminary based on a few files analyzed, need to follow up by checking all 80.

* Nearly all kmers are unique in assembled genomes and none seem to appear more than 4 times.
* Filtering matches in reads by PHRED score still leaves many false positives, but most appear only once. Most true positives are in a peak in the 10-100 range (depends on coverage, varied when I checked different genomes). Addional filter step by count threshold does a good job of removing these.
* Precision and recall > .995 is possible when correct thresholds are chosen, but results are not highly sensitive to these values.


## Results

* Total count of kmers in an (assembled) genome doesn't seem to convey useful information.
* Kmer signatures calculated directly from raw sequencing reads in FASTQ files match those from assembled genomes extremely well. Thresholding by read quality and # of matches is required. 