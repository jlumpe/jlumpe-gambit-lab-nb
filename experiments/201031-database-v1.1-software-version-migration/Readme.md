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


## Output

* `data/intermediate/201031-database-v1.1-software-version-migration/`
  * `201102-download-taxa/`
    * `taxa.json` - Data for all downloaded taxa
    * `aka_taxids.json` - mapping from NCBI alias taxonomy IDs to "canonical" IDs