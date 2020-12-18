# 201218 species manual taxon matches

Manual selection of proper 2020 NCBI taxa corresponding to genus/species names in current MIDAS database (v1 schema), and taxa to assign genomes to when migrating to the new v2 schema. Corrections to results of automated matching in `201122-taxon-name-matching` for those species names for which a match either could not be found or was not of species rank.

Revision of `201128-species-manual-taxon-matches-draft.md`.
Primarily relies on report generated in `201215-unmatched-species-taxonomy-trees`, which is an update to the `201125-unmatched-species-taxonomy-trees` report used to write the draft version.
The draft document (and older taxonomy tree report) is based on the NCBI assembly database data downloaded in 2016 for each genome. Each assembly database entry had an assigned taxonomy ID in 2016, and the draft attempted to resolve discrepancies between the taxonomy data downloaded in 2016 for these IDs and the current data downloaded in this experiment. This included taxa being renamed, changing rank, or being refiled under a different ancestry.

The new report used in this document takes into account the current assembly database data for each genome, for which the assigned taxonomy ID may have changed since 2016.


## Summary of matches/assignments

| Species name                                      | Genome Count | Matched Taxon                                              | Assigned taxon                             | Additional actions required? |
|---------------------------------------------------|--------------|------------------------------------------------------------|--------------------------------------------|------------------------------|
| Actinomyces odontolyticus                         |            2 | Schaalia odontolytica (1660)                               | (same)                                     | no                           |
| Azospirillum brasilense                           |            4 | Azospirillum brasilense (192)                              | (same)                                     | yes                          |
| Francisella noatunensis                           |            6 | Francisella noatunensis (657445)                           | Francisella orientalis (299583)            | no                           |
| Lachnoclostridium \[Clostridium\] clostridioforme |            9 | Enterocloster clostridioformis (1531)                      | (same)                                     | no                           |
| Mobiluncus curtisii                               |            4 | Mobiluncus curtisii (2051)                                 | (same)                                     | yes                          |
| Mycobacterium intracellulare                      |            9 | Mycobacterium intracellulare (1767)                        | (same)                                     | yes                          |
| Pectobacterium carotovorum                        |           35 | Pectobacterium carotovorum (554)                           | (same)                                     | yes                          |
| Pectobacterium wasabiae                           |            6 | Pectobacterium wasabiae (55208)                            | (same)                                     | yes                          |
| Photorhabdus luminescens                          |            7 | Photorhabdus luminescens (29488)                           | (same)                                     | yes                          |
| Photorhabdus temperata                            |            4 | Photorhabdus temperata (574560)                            | (same)                                     | yes                          |
| Pseudoalteromonas haloplanktis                    |            6 | Pseudoalteromonas haloplanktis (228)                       | None                                       | no                           |
| Pseudomonas pseudoalcaligenes                     |            2 | Pseudomonas oleovorans (301)                               | (same)                                     | no                           |
| Salinispora pacifica                              |           37 | Salinispora pacifica (351187)                              | (same)                                     | yes                          |
| Vibrio alginolyticus                              |           21 | Vibrio alginolyticus (663)                                 | (same)                                     | yes                          |
| Vibrio tasmaniensis                               |            6 | Vibrio tasmaniensis (212663)                               | (same)                                     | yes                          |
| Xanthomonas alfalfae                              |            3 | Xanthomonas alfalfae (366650)                              | Xanthomonas euvesicatoria (456327)         | no                           |
| Xanthomonas axonopodis                            |           79 | Xanthomonas axonopodis (53413)                             | Xanthomonas phaseoli (1985254)             | yes                          |
| Xanthomonas campestris                            |           29 | Xanthomonas campestris (339)                               | (same)                                     | yes                          |
| Xanthomonas fuscans                               |           18 | Xanthomonas citri pv. fuscans (366649)                     | Xanthomonas citri (346)                    | yes                          |
| Bifidobacterium kashiwanohense                    |            3 | Bifidobacterium catenulatum subsp. kashiwanohense (630129) | Bifidobacterium catenulatum (1686)         | no                           |
| Enterobacter xiangfangensis                       |           10 | Enterobacter hormaechei subsp. xiangfangensis (1296536)    | Enterobacter hormaechei (158836)           | no                           |
| Mycobacterium africanum                           |           22 | Mycobacterium tuberculosis variant africanum (33894)       | Mycobacterium tuberculosis (1773)          | no                           |
| Mycobacterium bovis                               |           66 | Mycobacterium tuberculosis variant bovis (1765)            | Mycobacterium tuberculosis (1773)          | no                           |
| Xanthomonas gardneri                              |           11 | Xanthomonas hortorum pv. gardneri (2754056)                | Xanthomonas hortorum (56454)               | no                           |


Notes:

* "matched taxon" is the current NCBI taxon I think should be considered the same as the given 2016 genus/species name. "Assigned taxon" is the taxon I think the genomes of this genus/species name should be assigned to new in the new migrated version.
* An "assigned taxon" of "none" means the genomes previously assigned to this species name should be removed in the migrated version.


## Species without matches


### Actinomyces odontolyticus

Schaalia odontolytica is the LCA taxon (species rank) and NCBI taxonomy page lists "Actinomyces odontolyticus Batty 1958" as a homotypic synonym.


### Azospirillum brasilense

3 of 4 genomes originally assigned to taxa which now fall under Azospirillum brasilense, 1 was originally classified as subspecies Sp245 which seems to have been reclassified as a separate species "baldaniorum". Remove.


### Francisella noatunensis

All original genome taxa were under "Francisella noatunensis subsp. orientalis" in the 2016 data, this subspecies seems to now be reclassified as its own species. Francisella noatunensis does still exist as its own entry in the NCBI taxonomy database, but all the genomes currently in the MIDAS database under that name should now be assigned to F. orientalis.


### Lachnoclostridium \[Clostridium\] clostridioforme

All genome taxa currently have same names as in 2016, which is "\[Clostridium\] clostridioforme" plus a strain #. However, their parent species is "Enterocloster clostridioformis".

NCBI taxonomy page for Enterocloster clostridioformis lists "Clostridium clostridioforme corrig. (Burri and Ankersmit 1906) Kaneuchi et al. 1976 (Approved Lists 1980)" as a basonym. Note at the bottom says "This taxonomic name has been effectively published but not validly published under the rules of the International Code of Nomenclature of Bacteria (Bacteriological Code)." The following reference at the bottom of the page looks relevant: "Reclassification of the Clostridium clostridioforme and Clostridium sphenoides clades as Enterocloster gen. nov. and Lacrimispora gen. nov., including reclassification of 15 taxa.".


### Mobiluncus curtisii

3 of 4 genomes have taxa which still fall under Mobiluncus curtisii as of 2020. One remaining genome was assigned to strain "Mobiluncus curtisii subsp. holmesii ATCC 35242", the holmesii subspecies seems to have been reclassified as its own species between then and now. Remove this genome.


### Mycobacterium intracellulare

7 of 8 genomes have original taxa which still fall under Mycobacterium intracellulare, remaining genome had taxon "Mycobacterium intracellulare MOTT-64" which is now apparently classified as its own species "Mycobacterium paraintracellulare". Remove this genome.

Additionally, there was one genome with original NCBI taxon in "Mycobacterium avium subsp. avium" which was reassigned to intracellulare by us during curation, the NCBI taxon has since been changed to intracellulare as well.


### Pectobacterium carotovorum

This is a difficult one. All 35 genomes were originally assigned to one of three subspecies or strains of them - subsp. carotovorum, subsp. brasiliense, or subsp. odoriferum. Subspecies brasiliense and odoriferum seem to have been reclassified as their own species. Additionally, two genomes in subsp. carotovorum have had their NCBI taxa reassigned to "Pectobacterium parvum".

Need to create the brasiliense, odiferum, and parvum species and reassign the appropriate genomes.
There were no additional genomes to deal with that were manually assigned to this species by us during curation.


### Pectobacterium wasabiae

3 of 6 genomes originally assigned to strains which seem to have been moved under a new species "parmentieri". Create parmentieri taxon and assign those genomes to it.


### Photorhabdus luminescens

2 of 7 genomes originally assigned to subspecies "laumondii" or a strain of it, this is now its own species. Create laumondii taxon and assign those genomes to it.


### Photorhabdus temperata

1 of 4 genomes originally assigned to subspecies "thracensis", now its own species. Remove.


### Pseudoalteromonas haloplanktis

All 6 genomes were originally assigned to separate strains of haloplanktis, all are now separate species under an "unclassified Pseudoalteromonas" taxon. Remove this species entirely.


### Pseudomonas pseudoalcaligenes

Pseudomonas oleovorans is the LCA taxon (species rank), NCBI taxonomy page lists "Pseudomonas pseudoalcaligenes" as heterotypic synonym.


### Salinispora pacifica

Original taxa of 27 of the 37 genomes are still strains of Salinispora pacifica. The 10 remaining were assigned to strains which are now their own species - fenicalii (2 genomes), oceanensis (3 genomes), vitiensis (2 genomes), and mooreana (3 genomes). Create taxa for these 3 new species and reassign the appropriate genomes to them.


### Vibrio alginolyticus

1 of 19 genomes originally assigned to strain which is now filed under its own species "diabolicus". Additional 2 genomes reassigned to diabolicus taxon in 2020 assembly data. Create diabolicus taxon and assign these genomes to it.


### Vibrio tasmaniensis

1 of 6 genomes reassigned to separate species "atlanticus". Remove.


### Xanthomonas alfalfae

2 of 3 genomes were originally assigned to strains within a taxon named "Xanthomonas alfalfae subsp. alfalfae" in 2016, but is now "Xanthomonas euvesicatoria pv. alfalfae". The third genome was assigned to "Xanthomonas axonopodis pv. citrumelo F1" (same name both in 2016 and 2020), the 2016 taxonomy summary data has the "species" field set to "alfalfae" despite the full name starting with "axonompodis". Not sure of the reason behind this anomaly but in the 2020 taxonomy tree this taxon is filed under the pathovar "Xanthomonas euvesicatoria pv. citrumelonis", so the original taxa of all 3 genomes now fall under the species "Xanthomonas euvesicatoria". This species already exists in the current database with 29 genomes, so these 3 genomes should just be merged into it. Note that there does exist a separate "Xanthomonas alfalfae" species in the current NCBI taxonomy database, so don't consider this a proper "match".


### Xanthomonas axonopodis

The 79 genomes were originally assigned under one of 4 pathovars of X. axonopodis: "manihotis" (66 genomes), "dieffenbachiae" (3 genomes), "phaseoli" (9 genomes), and "syngonii" (1 genome). Each of these seems to have been individually refiled under the species X. phaseoli, although X. axonopodis itself still exists in the NCBI database as a separate species. Create an entry in the new database for X. phaseoli and assign these genomes to it, but don't record phaseoli as a "match" to axonopodis in whatever metadata is recorded to describe this change.


### Xanthomonas campestris

5 of 29 genomes originally assigned to strains which have now been filed under "Xanthomonas vasicola". An additional 13 genomes had their NCBI-assigned taxon changed to "Xanthomonas arboricola" in the newest 2020 assembly data. Both of these species already exist in the current database, so just reassign these genomes.


### Xanthomonas fuscans

14 of 16 genomes originally assigned to "Xanthomonas fuscans subsp. fuscans", which is now known as "Xanthomonas citri pv. fuscans". The remaining two genomes were assigned to strains starting with "Xanthomonas fuscans subsp. aurantifolii", these are now filed under the no-rank taxon "Xanthomonas citri pv. aurantifolii". The species name "Xanthomonas citri" already exists in the database with 51 assigned genomes, however the LCA of all original taxa for these genomes is "Xanthomonas citri pv. citri".

For now, just assign all genomes in fuscans to citri. May want to later create these three pathovar taxa if it helps resolve any overlaps that may remain.

Note that there were an additional 2 genomes excluded from the main tree because they were reassigned to X. fuscans by us during original curation steps. Both are assigned to the same taxon, originally called "Xanthomonas axonopodis pv. phaseoli" and now called "Xanthomonas phaseoli pv. phaseoli". Assign these to citri along with the rest for now, but seems possible these may need to be edited again if the create overlaps.



## Species with matched taxa below species level


### Bifidobacterium kashiwanohense

Automated match to "Bifidobacterium catenulatum subsp. kashiwanohense" seems correct, NCBI taxonomy page lists "Bifidobacterium kashiwanohense" as a basionym. Species B. catenulatum already exists in database (4 genomes). Reassign genomes to it.

### Enterobacter xiangfangensis

Automated match to "Enterobacter hormaechei subsp. xiangfangensis" seems correct, NCBI taxonomy page lists "Enterobacter xiangfangensis" as "homotypic genbank synonym." Species E. hormaechei already exists in database (192 genomes). Reassign genomes to it.


### Mycobacterium africanum

Automated match to "Mycobacterium tuberculosis variant africanum" seems correct, NCBI taxonomy page lists "Mycobacterium africanum" as a "heterotypic genbank synonym." Species M. tuberculosis already exists in database. Reassign these genomes to it.


### Mycobacterium bovis

Automated match to "Mycobacterium tuberculosis variant bovis" seems correct, NCBI taxonomy page lists "Mycobacterium bovis" as a "heterotypic genbank synonym." Species M. tuberculosis already exists in database. Reassign these genomes to it.


### Xanthomonas gardneri

Automated match to "Xanthomonas hortorum pv. gardneri" seems correct, NCBI taxonomy page lists "Xanthomonas gardneri" as a heterotypic synonym. X. hortorum is not an existing species in the database. Just create a taxon for the X. hortorum species, not one for gardneri pathovar.



## Additional actions

Perform the following actions for the genomes falling under these taxa (according to taxids in newest NCBI assembly data):


| Species                      | Taxon                          |   Taxid | Genomes | Exists? | Action                            |
|------------------------------|--------------------------------|---------|---------|---------|-----------------------------------|
| Azospirillum brasilense      | Azospirillum baldaniorum       | 1064539 |       1 | n       | Remove genome                     |
| Mobiluncus curtisii          | Mobiluncus holmesii ATCC 35242 |  887899 |       1 | n       | Remove genome                     |
| Mycobacterium intracellulare | Mobiluncus paraintracellulare  | 1138383 |       1 | n       | Remove genome                     |
| Pectobacterium carotovorum   | Pectobacterium parvum          | 2778550 |       2 | n       | Create taxon and reassign genomes |
| Pectobacterium carotovorum   | Pectobacterium brasiliense     |  180957 |      22 | n       | Create taxon and reassign genomes |
| Pectobacterium carotovorum   | Pectobacterium odoriferum      |   78398 |       2 | n       | Create taxon and reassign genomes |
| Pectobacterium wasabiae      | Pectobacterium parmentieri     | 1905730 |       3 | n       | Create taxon and reassign genomes |
| Photorhabdus luminescens     | Photorhabdus laumondii         | 2218628 |       2 | n       | Create taxon and reassign genomes |
| Photorhabdus temperata       | Photorhabdus thracensis        |  230089 |       1 | n       | Remove genome                     |
| Salinispora pacifica         | Salinispora fenicalii          | 1137263 |       2 | n       | Create taxon and reassign genomes |
| Salinispora pacifica         | Salinispora oceanensis         | 1050199 |       3 | n       | Create taxon and reassign genomes |
| Salinispora pacifica         | Salinispora vitiensis          |  999544 |       2 | n       | Create taxon and reassign genomes |
| Salinispora pacifica         | Salinispora mooreana           |  999545 |       3 | n       | Create taxon and reassign genomes |
| Vibrio alginolyticus         | Vibrio diabolicus              |   50719 |       3 | n       | Create taxon and reassign genomes |
| Vibrio tasmaniensis          | Vibrio atlanticus              |  693153 |       1 | n       | Remove genome                     |
| Xanthomonas campestris       | Xanthomonas vasicola           |   56459 |       5 | y       | Reassign genomes                  |
| Xanthomonas campestris       | Xanthomonas arboricola         |   56448 |      13 | y       | Reassign genomes                  |



## Summary of differences from draft

This document contains the following alterations from `201128-species-manual-taxon-matches-draft.md`:

### Pectobacterium carotovorum

Two genomes originally assigned to Pectobacterium carotovorum subsp. carotovorum are now assigned to Pectobacterium parvum in the new assembly DB data, this species was not present in the previous report. An additional number of genomes originally assigned to Pectobacterium carotovorum subsp. carotovorum were also reassigned to Pectobacterium brasiliense in the 2020 assembly data (exact number not mentioned in report).

### Pectobacterium wasabiae

Original NCBI taxa for 2 of 6 genomes had been reassigned to Pectobacterium parmentieri. In 2020 assembly data the taxonomy ID of one additional genome has been changed to point to parmenteiri.

### Pseudoalteromonas haloplanktis

Original NCBI taxa for 3 of 6 genomes had been reclassified as misc. other Pseudoalteromonas species, original taxa of other 3 remained in haloplanktis. In the 2020 assembly data, assigned taxonmy IDs for this 2nd set of genomes have changed to to point to taxa which are also other misc. Pseudoalteromonas species. This leaves all 6 genomes in separate Pseudoalteromonas species and none remaining in haloplanktis. Solution is now to remove all 6 genomes along with the haloplanktis species itself.

### Vibrio alginolyticus

In addition to the single genome who's 2016 taxon was refiled under Vibrio diabolicus, two more genomes were reassigned directly to diabolicus in the 2020 assembly data. Solution is now to create the diabolicus taxa and file these genomes under it, rather than just removing the first genome.

### Xanthomonas alfalfae

Xanthomonas euvesicatoria listed as matching taxon in summary table at beginning of draft, should instead just be assigned taxon because there does exist a separate Xanthomonas alfalfae taxon in the current NCBI database.

### Xanthomonas campestris

An additional 13 genomes had their NCBI-assigned taxon changed to "Xanthomonas arboricola" in the newest 2020 assembly data. These will be reassigned to that taxon.