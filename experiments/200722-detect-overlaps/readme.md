# 200722 Detect Overlaps

This experiment was meant to detect all overlaps in the new 1.1-beta version of the curated refseq database but was never quite finished.


## Notebooks

### 200722-find-taxon-diameters

Finds diameters of all species and genera - that is, the maximum distance between any two genomes. Writes results as CSV in processed data directory and also as serialized dictionaries in `tmp/` folder.

### 200722-find-taxon-diameters

Plots results of previous notebook.

### 200726-intra-taxon-distance-lower-bounds

Calculates lower bounds on all minimum inter-species and inter-genus distances without calculating all pairwise genome distances.


## Results

* Calculated diameters for all taxa and lower bounds for all minimum inter-taxon distances.


## Output

`data/processed/200722-detect-overlaps/`:

* `200722-genus-diameters.csv` - diameters of all genera, along with accession #s of genome pairs achieving the diameter
* `200722-species-diameters.csv` - diameters of all species, along with accession #s of genome pairs achieving the diameter
* `200726-species-min-dists.jld` - lower bounds on all minimum inter-species distances, hdf5 file created with JLD.jl. Contains `TriMatrix` data array and vector of species names for rows/columns.
* `200726-genus-min-dists.jld` - lower bounds on all minimum inter-genus distances. Same format as previous.