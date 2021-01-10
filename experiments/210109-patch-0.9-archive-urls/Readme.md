# 210109 Patch 0.9 archive URLs


This experiment patches the `refseq_curated_0.9_160906` archive file to update the FTP URLs in the genome metadata so that the sequence data can be downloaded.

This archive file was used in the 160906 installer of the v1 CLI app which had been heavily tested "in the field" at Alameda public health labs. We would like to recreate a working version of this to compare results against the newer version of the app. The problem is that this version of the software isn't distributed with genome signatures in binary format, it relies on downloading the sequence data for each genome from NCBI and then calculating the signatures from that. NCBI changed the layout of their FTP server between 2016 and now, meaning the URLs in the metadata of that archive are no longer valid.

This notebook fetches ESummary data for each genome to find the updated URL for each, then writes the updated data to a new archive file. That file should be able to be substituted for the original to create an updated installer.