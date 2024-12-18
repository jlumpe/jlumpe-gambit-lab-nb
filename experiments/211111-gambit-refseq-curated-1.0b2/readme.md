# 211102 gambit-refseq-curated-1.0b2

This experiment makes some minor edits to the `gambit/refseq-curated` `1.0b1` genome database to yield
version `1.0b2`.


## Notebooks

### 211111-gambit-refseq-curated-1.0b2

Create version `1.0b2` of the refseq-curated database. Changes from `1.0b1`:

* Created new "E. coli" taxon (internal id=1917) corresponding to NCBI taxid 562. Set `report`
  property to True and `distance_threshold` to 0, meaning it will be used for reporting only and not
  for direct classification.
* Inserted E. coli in taxonomy tree between "E. coli/Shigella" (id=1862) and E. coli subgroup taxa
  (ids=1892,1893,1894).
* Changed rank of "E. coli/Shigella" taxon from "species" to None/null.


### 211116-gambit-refseq-curated-1.0b2-rev2

Creates revision of database created in previous notebook. Realized I forgot to update the
`organism` column of the genomes under the new E. coli taxon created in previous notebook. This
revision makes that update and also updates the `revision` key of the genome set's `extra` column.


## Output

* `archive/` - output not added to version control, meant to be archived elsewhere.
  * `gambit-genomes-1.0b2-211111.db` - new genome database file.
  * `gambit-genomes-1.0b2-rev2-211116.db` - revision 2 of new database.

