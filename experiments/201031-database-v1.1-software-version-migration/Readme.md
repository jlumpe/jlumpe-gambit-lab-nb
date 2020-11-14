# 201031-database-v1.1-software-version-migration

The purpose of this experiment is to migrate the information in the v1.1 (beta) database (created 200525) from version 1 to version 2 of the core MIDAS library database schema.


## Notebooks


### 201031-migrate-genomes

Creates a fresh database using schema from latest `midas` package version `2.2.0` and migrates all genome entries from archive file of v1.1 (beta) database. Does not attempt to create entries in new `taxa` table from the `gb_tax_summary` attribute of genomes in the archive file, instead just records the taxonomy IDs of all genomes so that the up-to-date taxonomy information can be downloaded in the next notebook.

#### Output

* `db.sqlite` file in working directory, containing base genome data in `v2.2.0` schema. Taxonomy and additional genome annotation data to be added by following notebooks.
* `tmp/genome_taxids.json` - list of NCBI taxonomy IDs for all genomes added to new database file.


### 201102-download-taxa

Downloads entries from NCBI taxonomy database for all genomes in database. Starts with *original* NCBI-assigned taxonomy IDs from each genome and recursively includes all parents/ancestors.

#### Output

Taxonomy data saved in JSON format in intermediate data directory for notebook.


### 201102-inspect taxa

Inspects the structure of the taxonomy tree for all taxa in previous notebook. In particular looks at the distribution of taxonomic ranks and how they are related to each other, and which might be useful in building this and future reference databases.

#### Results

There are many taxa with ranks outside of the main KPCOFGS hierarchy. Filtered out those with a rank of "no rank" or "clade" before doing the analysis, because these weren't actual ranks (didn't fit into a hierarchy with the other ranks, taxa were at all different levels). Rank relationships are fairly simple above the species level, but get more complex/messy below it.

The most significant non-standard taxon is "strain", which is at the bottom of the hierarchy. I'm guessing this rank is probably too granular to be of much use, but this may have to be evaluated on a species-by-species basis. There are a lot of "subspecies" taxa which may be of use when breaking up species to fix overlaps.

For the database being built in this experiment, it's probably only necessary to include taxa of rank "species" and "genus". It would be pretty each to complete the tree with family, order, class, phylum taxa but it doesn't seem very necessary at this point.

The next version of the database will need to include the thresholds for all taxa in a way which resolves remaining overlaps, and there are definitely cases where a single consistent threshold cannot be assigned at the species level. These cases will require splitting the species into sub-taxa with their own threshold distances, and I expect that using some of the sub-species taxa in this data set will be sufficient for many of them (others might require creating our own custom taxonomic divisions).


### 201104-inspect taxa

Re-run of previous after I noticed an error, the `aka_taxids` dict didn't convert the keys from string to int when loading from JSON so taxonomy ID aliases weren't looked up correctly. This doesn't seem to have made any difference in any of the results.


### 201109-match-taxa

Attempts to match curated genus and species names in the v1.1 database to NCBI taxa downloaded in `201102-download-taxa`. Attempts to match by name, under the constraint that the matched taxon must be an ancestor of the original NCBI-assigned taxon of one of the genomes in that group.

#### Results

Was not able to match all taxa using this method, probably because some of the entries in the NCBI taxonomy database have changed/been edited since 2016. Two of 419 genera and 101 of 1438 species could not be matched.


### 201109-extract-additional-taxonomy-data

Entries from NCBI taxonomy database were downloaded in XML format (no other option) in `201102-download-taxa` and converted to JSON for easier use in other notebooks. Was not familiar with the XML schema and did not inspect the results fully, so JSON output did not contain all information. Found out later there is an `<OtherNames>` tag in some entries which contains useful information. This notebook checks full set of child tags present in all entries to find if there may be any more useful information, and exports that information to an additional JSON file.

#### Results

Didn't find any additional useful parts of schema apart from `<OtherNames>` tag. Exported information from this tag in all entries to another JSON file.


### 201113-original-genome-taxa

Extract ESummary data for original NCBI-assigned taxa of genomes from v0.9 archive (which was downloaded in 2016, as opposed to in the v1.1 archive where this data was downloaded again in 2020). This was the data used to assign genus/species names to genomes in the original database.

Used the following steps to attempt to find the single taxon which best matches each curated genus/species name combination:

1. Collect original NCBI-assigned taxonomy IDs for all genomes assigned to the genus/species name in the v1.1 database (most recent)
2. Filter out taxa for which the genus/species names in the corresponding 2016 ESummary data don't match the v1.1 curated values (these genomes were probably reassigned to this species during curation)
3. Find the lowest common ancestor of these taxa using the up-to-date taxonomy tree downloaded for this experiment. This should probably correspond to the correct taxon in most cases, or possibly a descendant of it.

#### Results

Lowest common ancestor was at species rank or below for all but 12 of the 1438 species names. Of the remaining, 2 were species groups and 10 were genera. Will examine further in future notebook.


## Output

* `data/intermediate/201031-database-v1.1-software-version-migration/`
  * `201102-download-taxa/`
    * `taxa.json` - Data for all downloaded taxa
    * `aka_taxids.json` - mapping from NCBI alias taxonomy IDs to "canonical" IDs
  * `201109-match-taxa/`
    * `genus-map.json` - (partial) map from curated genus names to NCBI taxonomy IDs
    * `species-map.json` - (partial) map from curated genus/species names to NCBI taxonomy IDs
  * `201109-extract-additional-taxonomy-data/`
    * `taxon-othernames.json` - Contents of `<OtherNames>` tag for all taxa from `201102-download-taxa` which have it.
  * `201113-original-genome-taxa/`
    * `original-tax-summaries.json` - Original taxonomy database ESummary results extracted from metadata in v0.9 archive (downloaded 2016).
    * `genome-matching-taxids-by-species.json` - Original NCBI taxonomy IDs assigned to genomes in each species (by v1.1 archive), filtering out those for which the genus and species name in the corresponding taxonomy summary data do not match the assigned species.
    * `species-genome-lcas.json` - Least common ancestor of each set of filtered taxonomy IDs in previous data file.
* `data/processed/201031-database-v1.1-software-version-migration/`
  * `201109-match-taxa/`
    * `201109-db-v1.1-unmapped-taxa.csv` - table of unmapped post-curation genera and species along with the corresponding set of original NCBI-assigned taxa for their genomes.
