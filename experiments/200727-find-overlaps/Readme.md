# 200727 Find overlaps

This is a new experiment/set of notebooks to check for overlaps in the new "1.1"/rebuild database (beta version created 200604). In contrast to the last one on 200722 which tried to use fancy math to reduce the number of pairwise distances that needed to be checked, this one will start off by brute-forcing the entire pairwise distance matrix using a beastly Google Cloud VM.


## Notebooks

### 200727-calculate-pw-distances

Calculates all pairwise distances for signature set and saves as raw `Float32` data array, in layout used by `TriMatrices.jl`.

#### Output

* `data/intermediate/200727-find-overlaps/genome-pw-distances.raw-float32`


### 200729-find-species-overlaps

Finds min inter and max intra relationships for each genome and identifies which cause species overlaps. Finds groups of species which have overlaps between them.

#### Results

147 species have overlaps, grouped into 41 connected components. Total number of genomes with overlaps is 23786, nearly half.

#### Output

* `data/intermediate/200727-find-overlaps/200729-refseq-curated-1.1_beta-species-overlaps.h5`



## Results


## Output

* `data/intermediate/200727-find-overlaps/`
  * `genome-pw-distances.raw-float32` - Raw binary data for `Vector{Float32}`, data for `TriMatrix{Symmetric{False}}` of pairwise distances for all signatures in signature set.
  * `200729-refseq-curated-1.1_beta-species-overlaps.h5` - HDF5 file containing min inter and max intra (distances + indices) for each genome, plus some other basic data on overlaps found.