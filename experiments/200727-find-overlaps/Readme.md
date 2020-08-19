# 200727 Find overlaps

This is a new experiment/set of notebooks to check for overlaps in the new "1.1"/rebuild database (beta version created 200604). In contrast to the last one on 200722 which tried to use fancy math to reduce the number of pairwise distances that needed to be checked, this one will start off by brute-forcing the entire pairwise distance matrix using a beastly Google Cloud VM.


## Notebooks

### 200727-calculate-pw-distances

Calculates all pairwise distances for signature set and saves as raw `Float32` data array, in layout used by `TriMatrices.jl`.


## Results


### Output

* `200727-find-overlaps`
  * `data/intermediate/200727-calculate-pw-dists/genome-pw-distances.raw-float32` - Raw binary data for `Vector{Float32}`, data for `TriMatrix{Symmetric{False}}` of pairwise distances for all signatures in signature set.