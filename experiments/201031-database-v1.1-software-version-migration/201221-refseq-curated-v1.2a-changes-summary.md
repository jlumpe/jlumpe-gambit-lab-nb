# 201221 Refseq curated v1.2a changes summary

Summary of changes from v1.1 of MIDAS curated refseq database to version v1.2(alpha).

These changes involve a migration from the software v1.x schema to the v2.x schema.
This migration was non-trivial because in the v2.x schema taxa are explicitly stored in a dedicated
table of the database, while in v1.x each genome was only assigned a genus and species name.
When the original version of this database was first created in 2016 every genus/species name
combination was derived from a unique entry in the NCBI taxon database, which was not stored
explicitly. This new database version attempts to re-derive this mapping so that each database taxon
(species and genus) corresponds to a unique NCBI taxon. This is complicated due to information in
the NCBI taxonomy and assembly databases changing between 2016 and now. The changes made in this new
version beyond simply migrating to the new schema are to resolve discrepancies caused by these changes.
See document `201218-species-manual-taxon-matches` for more detailed information.


| Statistic     |  v1.1 | v1.2a |
|---------------|-------|-------|
| Genome count  | 50752 | 50741 |
| Species count |  1438 |  1438 |
| Genus count   |   419 |   462 |


## Species-level changes

The large majority of species names in the v1.1 database were able to be mapped to a single unique
entry in the NCBI taxonomy database. The following changes needed to be made:

* 7 species merged into other existing species.
* 6 species removed entirely.
* 13 new species created.

Total species count remains the same at 1438.


### Merged species

The following pairs of species names mapped to the same taxon, due to their 2016 taxa being merged
in the NCBI database:

| Taxon                     | TaxId | Species names               |
|---------------------------|-------|-----------------------------|
| Bacillus mycoides         |  1405 | Bacillus mycoides           |
|                           |       | Bacillus weihenstephanensis |
| Streptomyces californicus | 67351 | Streptomyces californicus   |
|                           |       | Streptomyces puniceus       |
| Vibrio cholerae           |   666 | Vibrio cholerae             |
|                           |       | Vibrio albensis             |

These species names were mapped to NCBI taxa which since 2016 have been refiled as subspecies of another
species already in the database. These taxa were not added to the new database, and their genomes
were reassigned to the species-level ancestor.

| Species name                   | Genomes | Refiled under               |  TaxID |
|--------------------------------|---------|-----------------------------|--------|
| Bifidobacterium kashiwanohense |       3 | Bifidobacterium catenulatum |   1686 |
| Enterobacter xiangfangensis    |      10 | Enterobacter hormaechei     | 158836 |
| Mycobacterium africanum        |      22 | Mycobacterium tuberculosis  |   1773 |
| Mycobacterium bovis            |      66 | Mycobacterium tuberculosis  |   1773 |


### Deleted species

The following species names were not mapped to any single taxon and were removed. In most cases all
their genomes were refiled under another species taxon.

| Species name                   | Genomes | Genomes assigned to       |   TaxId |
|--------------------------------|---------|---------------------------|---------|
| Francisella noatunensis        |       6 | Francisella orientalis    |  299583 |
| Pseudoalteromonas haloplanktis |       6 | None (genomes deleted)    |         |
| Xanthomonas alfalfae           |       3 | Xanthomonas euvesicatoria |  456327 |
| Xanthomonas axonopodis         |      79 | Xanthomonas phaseoli      | 1985254 |
| Xanthomonas fuscans            |      18 | Xanthomonas citri         |     346 |
| Xanthomonas gardneri           |      11 | Xanthomonas hortorum      |   56454 |


### New species

The following new taxa were created with genomes previously assigned to a different species name:

| Taxon                      |   TaxId | Source species name        | Genomes |
|----------------------------|---------|----------------------------|---------|
| Francisella orientalis     |  299583 | Francisella noatunensis    |       6 |
| Pectobacterium brasiliense |  180957 | Pectobacterium carotovorum |      22 |
| Pectobacterium odoriferum  |   78398 | Pectobacterium carotovorum |       2 |
| Pectobacterium parmentieri | 1905730 | Pectobacterium wasabiae    |       3 |
| Pectobacterium parvum      | 2778550 | Pectobacterium carotovorum |       2 |
| Photorhabdus laumondii     | 2218628 | Photorhabdus luminescens   |       2 |
| Salinispora fenicalii      | 1137263 | Salinispora pacifica       |       2 |
| Salinispora mooreana       |  999545 | Salinispora pacifica       |       3 |
| Salinispora oceanensis     | 1050199 | Salinispora pacifica       |       3 |
| Salinispora vitiensis      |  999544 | Salinispora pacifica       |       2 |
| Vibrio diabolicus          |   50719 | Vibrio alginolyticus       |       3 |
| Xanthomonas hortorum       |   56454 | Xanthomonas gardneri       |      11 |
| Xanthomonas phaseoli       | 1985254 | Xanthomonas axonopodis     |      79 |


### Other anomalies

The species taxon "[Eubacterium] siraeum" (TaxID 39492, 2 genomes) had no ancestor of genus rank.
The v1.1 species name mapped to this taxon was "[Eubacterium] siraeum", with the genus name
"Ruminiclostridium".



## Genome-level changes

Several smaller sets of genomes were moved between species or removed entirely.
See `201218-species-manual-taxon-matches` for details.
