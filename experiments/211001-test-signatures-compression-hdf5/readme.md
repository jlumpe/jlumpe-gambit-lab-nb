# 211001 Test Signatures Compression HDF5

Tests new feature of the HDF5 signature storage format which allows using HDF5's built-in
compression to reduce the size of the k-mer index array. Uses the 192 signature files created in the
`210902-mash-Escherichia-genomes` experiment with different k-mer parameters, each containing the
signatures of 492 genomes.


## Notebooks

### 211001-benchmarks

Writes new signature files with both gzip (default level of 4) and lzf compression.
Benchmarks reading all signatures at once (by copying the values array to memory) and one at a time
(by iterating through the signatures). Runs 5 trials.

Will analyze data in next notebook.


## Output

* `data/intermediate/211001-test-signatures-compression-hdf5/`
  * `211001-benchmarks/`
    * `signature-sets.csv` - basic information on each source signature file.
    * `file-sizes.csv` - File size for each compression method.
    * `signature-sets.csv` - Read times in microseconds for all compression methods and both read
      methods (all-at-once or one-at-a-time).
