# 201128 species manual taxon matches (draft)

Manual selection of proper 2020 NCBI taxa corresponding to genus/species names in current MIDAS database (v1 schema), and taxa to assign genomes to when migrating to the new v2 schema. Corrections to results of automated matching in `201122-taxon-name-matching` for those taxa for which a match either could not be found or was not of species rank. Primarily relies on report generated in `201125-unmatched-species-taxonomy-trees`. Draft version to be cleared with David.


## Summary of matches/assignments

| Genus | Species | Genome Count | Matched Taxon | Assigned taxon | Additional actions required? |
|----|----|-|------|------|--|
| Actinomyces | odontolyticus | 2 | [Schaalia odontolytica](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=1660) (1660) | (same) | |
| Azospirillum | brasilense | 4 | [Azospirillum brasilense](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=192) (192) | (same) | yes |
| Bifidobacterium | kashiwanohense | 3 | [Bifidobacterium catenulatum subsp. kashiwanohense](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=630129) (630129) | same or [Bifidobacterium catenulatum](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=1686) (1686) | |
| Enterobacter | xiangfangensis | 10 | [Enterobacter hormaechei subsp. xiangfangensis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=1296536) (1296536) | same or [Enterobacter hormaechei](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=15883e) (158836) | |
| Francisella | noatunensis | 6 | [Francisella noatunensis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=657445) (657445) | [Francisella orientalis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=299583) (299583) | | |
| Lachnoclostridium | \[Clostridium\] clostridioforme | 9 | [Enterocloster clostridioformis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=1531) (1531) | (same) | |
| Mobiluncus | curtisii | 4 | [Mobiluncus curtisii](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=2051) (2051) | (same) | yes |
| Mycobacterium | africanum | 22 | [Mycobacterium tuberculosis variant africanum](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=33894) (33894) | same or [Mycobacterium tuberculosis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=33894) (33894) | |
| Mycobacterium | bovis | 66 | [Mycobacterium tuberculosis variant bovis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=1765) (1765) | same or [Mycobacterium tuberculosis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=33894) (33894) | |
| Mycobacterium | intracellulare | 9 | [Mycobacterium intracellulare](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=1767) (1767) | (same) | yes |
| Pectobacterium | carotovorum | 35 | [Pectobacterium carotovorum](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=554) (554) | (multiple) | yes |
| Pectobacterium | wasabiae | 6 | [Pectobacterium wasabiae](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=55208) (55208) | (same) | yes |
| Photorhabdus | luminescens | 7 | [Photorhabdus luminescens](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=29488) (29488) | (same) | yes |
| Photorhabdus | temperata | 4 | [Photorhabdus temperata](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=574560) (574560) | (same) | yes |
| Pseudoalteromonas | haloplanktis | 6 | [Pseudoalteromonas haloplanktis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=228) (228) | (same) | yes |
| Pseudomonas | pseudoalcaligenes | 2 | [Pseudomonas oleovorans](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=301) (301) | (same) | |
| Salinispora | pacifica | 37 | [Salinispora pacifica](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=351187) (351187) | (same) | yes |
| Vibrio | alginolyticus | 21 | [Vibrio alginolyticus](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=663) (663) | (same) | yes |
| Vibrio | tasmaniensis | 6 | [Vibrio tasmaniensis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=212663) (212663) | (same) | yes |
| Xanthomonas | alfalfae | 3 | [Xanthomonas euvesicatoria](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=456327) (456327) | (same) | |
| Xanthomonas | axonopodis | 79 | [Xanthomonas axonopodis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=53413) (53413) | [Xanthomonas phaseoli](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=1985254) (1985254) | yes |
| Xanthomonas | campestris | 29 | [Xanthomonas campestris](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=339) (339) | (same) | yes |
| Xanthomonas | fuscans | 18 | [Xanthomonas citri pv. fuscans](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=366649) (366649) | same or [Xanthomonas citri](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=346) (346) | yes |
| Xanthomonas | gardneri | 11 | [Xanthomonas hortorum pv. gardneri](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=2754056) (2754056) | same or [Xanthomonas hortorum](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=56454) (56454) | |


Notes:

* "matched taxon" is the current NCBI taxon I think should be considered the same as the given 2016 genus/species name. "Assigned taxon" is the taxon I think the genomes of this genus/species name should be assigned to new in the new migrated version.
* All genome counts in this document are for those genomes used to find the LCA taxon in `201113-original-genome-taxa`, does not include those genomes filtered out from this set because they were initially assigned to a different genus/species name and reassigned to this one during our curation process.


## Details


### Actinomyces odontolyticus

Schaalia odontolytica is the LCA taxon (species rank) and NCBI taxonomy page lists "Actinomyces odontolyticus Batty 1958" as a homotypic synonym.


### Azospirillum brasilense

3 of 4 genomes originally assigned to taxa which now fall under Azospirillum brasilense, 1 was originally classified as subspecies Sp245 which seems to have been reclassified as a separate species "baldaniorum". Possibly remove this genome?


### Bifidobacterium kashiwanohense

Automated match to "Bifidobacterium catenulatum subsp. kashiwanohense" seems correct, NCBI taxonomy page lists "Bifidobacterium kashiwanohense" as a basionym. Species B. catenulatum already exists in database (4 genomes). Create this specific subspecies taxon when migrating, or just assign genomes to existing species?


### Enterobacter xiangfangensis

Automated match to "Enterobacter hormaechei subsp. xiangfangensis" seems correct, NCBI taxonomy page lists "Enterobacter xiangfangensis" as "homotypic genbank synonym." Species E. hormaechei already exists in database (192 genomes). Create this specific subspecies taxon when migrating, or just assign genomes to existing species?


### Francisella noatunensis

All original genome taxa were under "Francisella noatunensis subsp. orientalis" in the 2016 data, this subspecies seems to now be reclassified as its own species. Francisella noatunensisdoes still exist as its own entry in the NCBI taxonomy database, but all the genomes currently in the MIDAS database under that name should now be assigned to F. orientalis.


### Lachnoclostridium \[Clostridium\] clostridioforme

All genome taxa currently have same names as in 2016, which is "\[Clostridium\] clostridioforme" plus a strain #. However, their parent species is "Enterocloster clostridioformis".

NCBI taxonomy page for Enterocloster clostridioformis lists "Clostridium clostridioforme corrig. (Burri and Ankersmit 1906) Kaneuchi et al. 1976 (Approved Lists 1980)" as a basonym. Note at the bottom says "This taxonomic name has been effectively published but not validly published under the rules of the International Code of Nomenclature of Bacteria (Bacteriological Code)." The following reference at the bottom of the page looks relevant: "Reclassification of the Clostridium clostridioforme and Clostridium sphenoides clades as Enterocloster gen. nov. and Lacrimispora gen. nov., including reclassification of 15 taxa.".


### Mobiluncus curtisii

3 of 4 genomes have taxa which still fall under Mobiluncus curtisii as of 2020. One remaining genome was assigned to strain "Mobiluncus curtisii subsp. holmesii ATCC 35242", the holmesii subspecies seems to have been reclassified as its own species between then and now. Possibly remove this genome?


### Mycobacterium africanum

Automated match to "Mycobacterium tuberculosis variant africanum" seems correct, NCBI taxonomy page lists "Mycobacterium africanum" as a "heterotypic genbank synonym." Use this taxon in when migrating or just assign genomes to parent M. tuberculosis taxon?


### Mycobacterium bovis

Automated match to "Mycobacterium tuberculosis variant bovis" seems correct, NCBI taxonomy page lists "Mycobacterium bovis" as a "heterotypic genbank synonym." Use this taxon in when migrating or just assign genomes to parent M. tuberculosis taxon?


### Mycobacterium intracellulare

7 of 8 genomes have original taxa which still fall under Mycobacterium intracellulare, remaining genome had taxon "Mycobacterium intracellulare MOTT-64" which is now apparently classified as its own species "Mycobacterium paraintracellulare". Remove this genome?


### Pectobacterium carotovorum

This is a difficult one. All 35 genomes were originally assigned to one of three subspecies or strains of them - subsp. carotovorum (15 genomes), subsp. brasiliense (16 genomes), or subsp. odoriferum (2 genomes). Subspecies brasiliense and odoriferum seem to have been reclassified as their own species. Seems like we should also add these other two species to the database and move the appropriate genomes to them. Will also have to make sure to appropriately deal with any other genomes beyond those 35 which were reassigned to this species name during our curation.


### Pectobacterium wasabiae

2 of 6 genomes originally assigned to strains which seem to have been moved under a new species "parmentieri". Remove these genomes, or create the new "parmentieri" species and assign those genomes to it?


### Photorhabdus luminescens

2 of 7 genomes originally assigned to subspecies "laumondii" or a strain of it, this is now its own species. Remove these genomes, or create the new "laumondii" species and assign those genomes to it?


### Photorhabdus temperata

1 of 4 genomes originally assigned to subspecies "thracensis", now its own species. Remove this genome?


### Pseudoalteromonas haloplanktis

3 of 6 genomes originally assigned to separate strains which have now been reclassified as their own species outside of haloplanktis (and under a rankless taxon called "unclassified Pseudoalteromonas"). Probably should remove these genomes.


### Pseudomonas pseudoalcaligenes

Pseudomonas oleovorans is the LCA taxon (species rank), NCBI taxonomy page lists "Pseudomonas pseudoalcaligenes" as heterotypic synonym.


### Salinispora pacifica

Original taxa of 27 of the 37 genomes are still strains of Salinispora pacifica. The 10 remaining were assigned to strains which are now their own species - fenicalii (2 genomes), oceanensis (3 genomes), vitiensis (2 genomes), and mooreana (3 genomes). Remove these 10 genomes, or add these 4 new species and reassign the genomes to them?


### Vibrio alginolyticus

1 of 19 genomes originally assigned to strain which is now filed under its own species "diabolicus". Remove this genome?


### Vibrio tasmaniensis

1 of 6 genomes originally assigned to strain which is now filed under its own species "atlanticus". Remove this genome?


### Xanthomonas alfalfae

2 of 3 genomes were originally assigned to strains within a taxon named "Xanthomonas alfalfae subsp. alfalfae" in 2016, but is now "Xanthomonas euvesicatoria pv. alfalfae". The third genome was assigned to "Xanthomonas axonopodis pv. citrumelo F1" (same name both in 2016 and 2020), the 2016 taxonomy summary data has the "species" field set to "alfalfae" despite the full name saying "axonompodis". Not sure of the reason behind this anomaly but in the 2020 taxonomy tree this taxon is filed under the pathovar "Xanthomonas euvesicatoria pv. citrumelonis", so the original taxa of all 3 genomes now fall under the species "Xanthomonas euvesicatoria". This species already exists in the current database with 29 genomes, so these 3 genomes should probably just be merged into it.


### Xanthomonas axonopodis

The 79 genomes were originally assigned under one of 4 pathovars of X. axonopodis: "manihotis" (66 genomes), "dieffenbachiae" (3 genomes), "phaseoli" (9 genomes), and "syngonii" (1 genome). Each of these seems to have been individually refiled under the species X. phaseoli, although X. axonopodis itself still exists in the NCBI database as a separate species. Create an entry in the new database for X. phaseoli and assign these genomes to it, but perhaps don't record phaseoli as a "match" to axonopodis in whatever metadata is recorded to describe this change.


### Xanthomonas campestris

5 of 29 genomes originally assigned to strains which have now been filed under "Xanthomonas vasicola", which is a species name which already exists in the database. Remove these genomes, or reassign them to vasicola?


### Xanthomonas fuscans

14 of 16 genomes originally assigned to "Xanthomonas fuscans subsp. fuscans", which is now known as "Xanthomonas citri pv. fuscans". The remaining two genomes were assigned to strains starting with "Xanthomonas fuscans subsp. aurantifolii", these are now filed under the no-rank taxon "Xanthomonas citri pv. aurantifolii". The species name "Xanthomonas citri" already exists in the database with 51 assigned genomes, however the LCA of all original taxa for these genomes is "Xanthomonas citri pv. citri". A good solution may be to create two subspecies taxa for the "citri" and "fuscans" pathovars both under a single "Xanthomonas citri" species taxon, and assign genomes to one of those two as appropriate. The two genomes originally assigned to "Xanthomonas fuscans subsp. aurantifolii" could be assigned directly to the species taxon, or removed. Alternatively, we could just assign all the genomes currently filed under both X. funscans and X. citri directly to the X. citri species taxon.


### Xanthomonas gardneri

Automated match to "Xanthomonas hortorum pv. gardneri" seems correct, NCBI taxonomy page lists "Xanthomonas gardneri" as a heterotypic synonym. X. hortorum is not an existing species in the database. Just create a taxon for the X. hortorum species, not one for gardneri pathovar.



## Additional actions required

* Remove single genomes originally assigned to taxa which have now been moved to a different species?
  * Azospirillum brasilense taxon now named "Azospirillum baldaniorum"
  * Mobiluncus curtisii taxon now named "Mobiluncus holmesii ATCC 35242"
  * Mycobacterium intracellulare taxon now named "Mobiluncus paraintracellulare"
  * Photorhabdus temperata taxon now named "Photorhabdus thracensis"
  * Vibrio alginolyticus taxon now named "Vibrio diabolicus E0666"
  * Vibrio tasmaniensis taxon now named "Vibrio atlanticus LGP32"
* Remove multiple genomes assigned to taxa which now fall under a new species, or also add that species to the database and reassign those genomes to it.
  * 2 Pectobacterium wasabiae genomes now under "parmentieri" species
  * 2 Photorhabdus luminescens genomes now under "laumondii" species
  * 10 Salinispora pacifica genomes - 2 to "fenicalii", 3 to "oceanensis", 2 to "vitiensis", 3 to "mooreana"
  * 5 Xanthomonas campestris genomes now under "vasicola" species (species already exists in current database)
* Refile genomes currently under "Pectobacterium carotovorum" to the appropriate one of the three new Pectobacterium species.
* Remove 3 Pseudoalteromonas haloplanktis genomes originally assigend to taxa which are now "unclassified Pseudoalteromonas" species.
* If using "Xanthomonas citri pv. fuscans" as the taxon for the "Xanthomonas fuscans" 2016 species name, also reassign all genomes previously under X. citri to a new "Xanthomonas citri pv. citri" taxon. Both of these pathovar taxa would fall under under a single "Xanthomonas citri" species taxon. Would also need to remove 2 genomes originally assigned to taxa which are now strains of "Xanthomonas citri pv. aurantifolii". None of this is needed if we are only keeping the "Xanthomonas citri" species taxon.
* Create new "Xanthomonas phaseoli" species taxon and reassign all X. axonopodis genomes to it, although this isn't really a "match" in the same sense as the others.
