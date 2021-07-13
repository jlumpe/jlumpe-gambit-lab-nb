# 210424 Database v1.2 fix remaining overlaps

The purpose of this experiment is to find and resolve all overlaps in the v1.2 database that remain
after the edits in `210401-database-v2-fix-species-overlaps`. That experiment resolved all overlaps
in "leaf" taxa (no children in the taxonomy tree), but overlaps from higher-level ("internal") taxa
still remain.



## Source files

### GridAxes.jl

Defines the `GridAxes` type, which helps to create a grid of subplots with `PlotlyJS`.



## Notebooks

### 210428-find-remaining-overlaps

Finds all remaining overlaps in database.

#### Results

119 of 471 internal taxa have outgoing overlaps.


### 210429-simple-overlap-plots

Creates and saves some simple Plotly plots:

* Scatter plots and histograms of some statistics of internal taxa grouped by with/without overlap.
* Heatmaps of max intra distances for Escherichia and Shigella leaf taxa along with min inter
  distances to overlapping taxa.

#### Results

Nearly all internal taxa with overlaps have diameter >~ .9 and min inter >~ .8, so threshold just
needs to be lowered to a still fairly large value to fix all of them. Escherichia and Shigella are
the exceptions, these need to be resolved separately (probably by merging).


### 210511-extra-overlap-data

Calculates some additional intermediate data based on taxa and overlaps to be used in other notebooks.


### 210513-overlap-pw-heatmaps

Heatmaps of maximum pairwise distances between leaves of each internal taxon with remaining overlaps.
Cells with distance exceeding the min inter score for the internal taxon are marked.

Intended to help identify leaves which may contain outliers driving the diameter of the ancestor
taxon up, contributing to overlaps.

#### Results

See many candidates for further investigation with regard to outliers, however many taxa have a very
large fraction of leaf PW distances over the min inter value.


### 210520-min-inter-outliers

Creates two sets of plots to search for "outlier" genomes that may be driving down each overlap
taxon's min inter score. The "src" plots show the 30 genomes within each parent taxon with the
smallest minimum distance to a genome outside the parent, and The "dst" plots show the 30 genomes
outside the parent taxon with the smallest minimum distance to a genome inside the parent. In both
sets of plots genomes are grouped and colored by their leaf taxon. Distance values are measured on
the Y axis, the position of the genome points has no meaning and is only used to arrange these them
clearly. The two genomes with the highest distance values within each leaf taxon (if one of the 30
genomes shown in the plot) are marked with X's to indicate that removing either of them (along with
all the closer ones) would leave the leaf taxon with less than the minimum genome count of two.

The gray filled area shows the ECDF on the parent taxon's intra distances for comparison, with the
p values on the X axis. The red dotted line is the parent's diameter. Comparing to the whole
distribution of intra distances instead of just the diameter is less influenced by outliers.

#### Results

There are some definite outlier genomes in both sets of plots, although not all would result in a
larger percentage of the parent taxon's inter distances being beneath the new min_inter value if
they were removed. Will examine further in next notebook.


### 210710-remove-min-inter-outliers

Designate genomes for removal based on results of previous experiment `210520-min-inter-outliers`.
Removed genomes from both "source" and "destination" sides of remaining overlaps. Made choices based
on how much the min-inter values could be increased vs. how many genomes were being removed relative
to the total number of genomes in the leaf taxa they were being removed from (pretty subjective).
Decisions made under the assumption that I would cap thresholds to 95% of min-inter value, even if
this is below the taxon diameter.

#### Results

Removed 20 genomes in total. In most cases did not totally resolve overlaps, but made significant
improvements to min_inter values for 7 internal taxa.


### 210712-find-max-intra-outliers

The object of this notebook was to locate outlier genomes or pairs of genomes which were driving up
the diameters / max-intra distances of genera or other non-leaf taxa. I assembled a list of candidates
by manually reviewing the plots from `210513-overlap-pw-heatmaps` to find instances where one or two
leaves which had much larger maximum distances to the other leaves within its genus. I then plotted
heatmaps showing the distances between the genomes in these leaves vs genomes in all other leaves to
determine if this was being caused by any particular genome or small set of genomes.

#### Results

Almost all candidates were immediately eliminated solely due to the range of distances (as shown by
the color bar in each plot). They were extremely small, indicating that only a very small improvement
could be gained by eliminating any number of genomes.

The sole exception was in Chronobacter (437) where C. turicensis (1405) was split into two pairs of
genomes, one of which had a maximum distance of .97 or so to the other leaves while the other was
only about .9. The distance between these two pairs was also about .97, compared to Chronobacter's
min-inter distance is about .95 This still isn't enough of a potential gain to justify messing with
it much, but making a note of it to potentially be addressed later.


## Output

* `data/intermediate/210428-database-v1.2-fix-remaining-overlaps/`
  * `210428-find-remaining-overlaps/`
    * `overlaps.json`: All overlaps found in this experiment. For each internal taxon with overlaps,
      lists overlaps from its leaves to outside leaf taxa, using the internal taxon's threshold.
    * `calculated.json`: Additional per-taxon data calculated in this notebook that will be useful
      to other notebooks in this experiment.
  * `210511-extra-overlap-data/`
    * `taxa.arrow`: Full taxa table with extra calculated data in Apache Arrow format.
    * `leaf-data.h5`: HDF5 file specifying linear ordering of leaf taxa along with aggregated
      pairwise distance matrices.

* `data/processed/210428-database-v1.2-fix-remaining-overlaps/`
  * `210428-find-remaining-overlaps/`
    * `210428-internal-taxa-overlaps-summary.csv`: Table summarizing overlaps and related data for
      all non-leaf taxa.
  * `210710-remove-min-inter-outliers`
    * `210710-removed-genomes.csv` - Table listing genomes to be removed, their assigned taxa, and
      reason for removal.
    * `210710-removed-genomes-by-taxon.csv` - Table summarizing number of removed genomes by (leaf)
      taxon.
    * `210710-min-inter-updates.csv` - Table listing improvements to min_inter values of internal
      taxa as a result of removed genomes.

* `reports/210428-database-v1.2-fix-remaining-overlaps/`
  * `210429-simple-overlap-plots/`
    * `210429-internal-taxa-diameters-histogram.html`: Histogram of taxon diameter.
    * `210429-internal-taxa-diameters-scatter.html`: 1D scatter plot of taxon diameter (random y).
    * `210429-internal-taxa-diameter-leaf-threshold.html`: Scatter of max leaf threshold vs diameter.
    * `210429-internal-taxa-diameter-leaf-threshold.html`: Scatter of min inter distance vs diameter.
    * `210429-Escherichia-overlap-heatmaps.html`: Heatmaps of max intra/min inter distances for Escherichia.
    * `210429-Shigella-overlap-heatmaps.html`: Heatmaps of max intra/min inter distances for Shigella.
  * `210513-overlap-pw-heatmaps/`
    * `210513-overlap-pw-heatmaps.html`: Heatmap for each internal taxon with remaining overlaps
      showing maximum pairwise distances between leaves. Red dot marks values greater than the
      taxon's min inter score.
  * `210520-min-inter-outliers/`
    * `210520-min-inter-outliers-by-src.html`: See section on notebook for description.
    * `210520-min-inter-outliers-by-dst.html`: See section on notebook for description.
