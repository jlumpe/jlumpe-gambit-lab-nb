# 210424 Database v1.2 fix remaining overlaps

The purpose of this experiment is to find and resolve all overlaps in the v1.2 database that remain
after the edits in `210401-database-v2-fix-species-overlaps`. That experiment resolved all overlaps
in "leaf" taxa (no children in the taxonomy tree), but overlaps from higher-level ("internal") taxa
still remain.


## Notebooks

### 210428-find-remaining-overlaps

Finds all remaining overlaps in database.

#### Results

119 of 471 internal taxa have outgoing overlaps.



## Output

* `data/intermediate/210428-database-v1.2-fix-remaining-overlaps/`
  * `210428-find-remaining-overlaps/`
    * `overlaps.json`: All overlaps found in this experiment. For each internal taxon with overlaps,
	  lists overlaps from its leaves to outside leaf taxa, using the internal taxon's threshold.
    * `calculated.json`: Additional per-taxon data calculated in this notebook that will be useful
      to other notebooks in this experiment.

* `data/processed/210428-database-v1.2-fix-remaining-overlaps/`
  * `210428-find-remaining-overlaps/`
    * `210428-internal-taxa-overlaps-summary.csv`: Table summarizing overlaps and related data for
      all non-leaf taxa.
