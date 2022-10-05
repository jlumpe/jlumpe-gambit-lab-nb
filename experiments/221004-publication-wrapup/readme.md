# 221004-publication-wrapup

Things to be done before submitting final manuscript + supplemental data later this week.


## Notebooks

### 221004-set4-ag-data

Match data table from Andrew Gorzalski about his NCBI submissions to set 4 genomes table.

#### Results

Manually matched IDs "21-00368644A" and "21-00368644B" (mine) to "21-00368644" and "21-00368644b" (Andrew's).
34 genomes are without a biosample accesison (one contained "QC Fail" for this field, erased).
The biosample accession "SAMN10182651" is duplicated between row IDs "PNUSAE019069" and "PNUSAE020883".


### 221005-set4-ag-data-diff

Andrew sent me a corrected version of his data, this notebook is to check what exactly changed.

#### Results

Updated two biosample accession nos:

* 22-00044713 from nothing to SAMN30965595
* PNUSAE020883 from SAMN10182651 to SAMN10619240

The second fixes the duplicated biosample accession between rows "PNUSAE019069" and "PNUSAE020883".


## Files


* `src/`
  * `220923-GAMBIT-Species-ID-Comparison-AG.xlsx`: Excel file recvd from Andrew on 220923. First two sheets from David, 3rd sheet contains Andrew's data.
  * `221005-ag-data_v2.csv` - Output table of 221004-set4-ag-data with corrections from Andrew.
* `data-processed/`
  * `221004-set4-ag-data/`
    * `221004-ag-data.csv`: Formatted version of Andrew's table, restricted to genomes in set4. "id" is the ID I have been using for set4 genomes, "entity:miniseq_id" is Andrew's.