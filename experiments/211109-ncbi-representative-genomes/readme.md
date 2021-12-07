# 211109 NCBI representative genomes

This project will download all bacterial genomes from NCBI labeled as "Reference" or
"Representative", for use in validation of method or publication.


## Notebooks

### 211111-find-genomes

Performs an ESearch query for NCBI assembly DB entries matching desired criteria, downloads ESummary
info for all.

#### Results

Found 14388 genomes.


### 211111-inspect-genomes

Extracts (potentially) relevant data from summaries and writes to table.

#### Results

- 15 with `refseq_category` "reference genome", rest "representative"
- `assembly_status` values:
  - Chromosome: 374
  - Complete Genome: 3370
  - Contig: 6176
  - Scaffold: 4468
- 4 genomes have GB accession #, not RefSeq. All submitted in the last two months (3 of them two
  days ago), can probably remove.
- `taxonomy_check_status` values (under `meta` key):
  - 11846 have "OK"
  - 2539 have "Inconclusive"
  - 3 have no value (key missing)
- `propertylist` values:
  - 216 have "partial-genome-representation"
  - 3751 have "has-chromosome"
  - 1218 have "has-plasmid"
- None have anything in `anomalouslist`
- Under `meta` key:
  - 42 have total assembly length < 500kb (down to 140kb), seems like large proportion of genome must
	be missing.

Other observations:

- `assembly_level` (int-valued) has one-to-many relationship to `assembly_status`. Not really sure
  what it means.

#### Next

Figure out if any of the following attributes are relevant and should be filtered on:

* `assembly_status`
* `taxonomy_check_status`
* `propertylist`
  * `partial-genome-representation`
  * `has-genome`
  * `has-plasmid`
* `total_length`


### 211115-download-genomes

Downloads genome sequences from NCBI FTP server to temporary directory. Checks their MD5 hashes.
Manually uploaded all `.fasta.gz` files to GCS bucket.


#### Results

The following had blank values for the `ftppath_refseq` attribute of their ESummary data:

* 10898551 GCA_003114835.2
* 11011431 GCF_017493175.2
* 11411721 GCA_003382565.3
* 11411751 GCA_016765655.2
* 11411881 GCA_016806835.2

Just skipped these, will exclude from further analysis.


### 211206-pw-dists

Get signatures for all genomes using ATGAC/11 spec and then calculate pairwise distances.


## Output

* `data/processed/211109-ncbi-representative-genomes/`
  * `211109-find-genomes/`
    * `genomes.csv` - (possibly) relevant properties of all genomes from search.

* `data/intermediate/211109-ncbi-representative-genomes/`
  * `211111-find-genomes/`
    * `assembly-summaries.tar.gz` - tarball of all assembly summaries in JSON format.
  * `211206-pw-dists/`
    * `pw-dists.h5` - Full pairwise distance matrix in HDF5 format.

* `gs://helical-song-136517/data/genomes/211109-ncbi-representative-genomes/`
  * `fasta/` - gzipped sequence files.
  * `211109-ncbi-representative-genomes-ATGAC_11-211206.h5` - GAMBIT signatures calculated with
    ATGAC/11 spec.

