# 200817 E coli sequence identity

The purpose of this experiment is to determine how well our Jaccard similarity score correlates with sequence identity in whole genome alignments. David provided six assembled E coli genomes along with a table of identity scores for pairwise alignments he performed using Mauve.


## Notebooks

### 200817-ecoli-percent-identity

Finds kmer signature for each genome using standard settings and calculates pairwise scores.

#### Output

* `data/processed/200817-ecoli-sequence-identity/200817-ecoli-pairwise-identity-jaccard-comparison.csv` - Input table with Jaccard score column added.

#### Results

Association between sequence identity and Jaccard score doesn't look so great. Two genomes ("102" and "103") are further away from the other four, the relationship mostly captures the difference between high and low similarity and doesn't have much correlation within those groups.