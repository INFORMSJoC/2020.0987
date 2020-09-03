[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the
[MPL2 license](LICENSE.md).

The software and data in this repository are associated with the paper
[SDDP.jl: a Julia package for stochastic dual dynamic programming](https://doi.org/10.1287/ijoc.2020.0987)
by O. Dowson and L. Kapelevich.

This repository is a snapshot of the project, taken on 2020-08-27 from
[https://github.com/odow/SDDP.jl](https://github.com/odow/SDDP.jl) at commit
[`c8c078c2f07bc3e3aa420c7d197e88ae819e56b1`](https://github.com/odow/SDDP.jl/commit/c8c078c2f07bc3e3aa420c7d197e88ae819e56b1),
and is provided for historical interest.

To cite this software, please cite the [paper](https://doi.org/10.1287/ijoc.2020.0987) using its DOI
and the software  itself, using the following DOI.

[![DOI](https://zenodo.org/badge/290669197.svg)](https://zenodo.org/badge/latestdoi/290669197)

Readers are directed to [https://github.com/odow/SDDP.jl](https://github.com/odow/SDDP.jl)
for the actively developed project repository, and to
[https://odow.github.io/SDDP.jl/latest/](https://odow.github.io/SDDP.jl/latest/)
for the latest documentation.

To run the example in the paper, first install any 1.X version of Julia (e.g.,
1.0 or 1.5) from [julialang.org](https://julialang.org/downloads). Then, run:
```
git clone https://github.com/INFORMSJoC/2020-01-OA-003
cd 2020-01-OA-003
julia --project=. -e 'import Pkg; Pkg.instantiate()'
julia --project=. examples/paper_models/dk_2020.jl
```
