# 201013 Overlap Clustering Analysis


This experiment will try to dig into some of the overlapping groups of species in the newest 1.x database using some new hierarchical clustering and plotting tools I have developed for this purpose. The objective is to hopefully find a minimum set of changes to the database that will resolve the overlaps.


## Notebooks

### 201013-hclust-plotting-demo

Test of new clustering and plotting utilities on a set of overlapping species with over 1000 genomes and a fairly high degree of complexity, which would be difficult or impossible to do with old tools. Created set of interactive PlotlyJS plots width dendrograms and heatmaps, using both old and new tools for comparison, to send to David for feedback.



## Output

* `data/processed/201013-overlap-clustering-analysis/`
  * `201013-hclust-plotting-demo/` - PlotlyJS dendrogram and clustermap plots for example problem, exported as interactive HTML.