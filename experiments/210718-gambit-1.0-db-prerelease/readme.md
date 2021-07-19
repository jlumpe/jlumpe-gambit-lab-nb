# 210718 Gambit 1.0 DB prerelease

This experiment is going to hastily assemble a re-release version of the GAMBIT 1.0 database just to
get it out there and get Kevin working with it as soon as possible. I will follow up with a "proper"
1.0 release with more careful tests and check for self-consistency.


## Notebooks

### 210718-compile-edits

Starting from the final taxonomy table resulting from `210401-database-v2-fix-species-overlaps`,
adds in changes from `210428-v1.2-fix-remaining-overlaps` (genome deletions in
`210710-remove-min-inter-outliers`), creates merged Escherichia/Shigella taxon, and assigns unique
values for the `key` column. This will be the full list of taxa in the created database.



## Output

* `data/intermediate/210718-gambit-1.0-db-prerelease/`
  * `210718-compile-edits/`
    * `taxa.csv` - table containing data for all taxa to be included in database, aside from
      threshold values.
