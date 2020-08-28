[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the
[MPL2 license](LICENSE.md).

The software and data in this repository are associated with the paper
[SDDP.jl: a Julia package for stochastic dual dynamic programming](https://doi.org)
by O. Dowson and L. Kapelevich. This repository is a snapshot of the project at
the time the paper was written and is provided for historical interest.

Readers are directed to [https://github.com/odow/SDDP.jl](https://github.com/odow/SDDP.jl)
for the actively developed project repository.

To run the example in the paper, first install any 1.X version of Julia (e.g.,
1.0 or 1.5) from [julialang.org](https://julialang.org/downloads). Then, run:
```
git clone https://github.com/INFORMSJoC/2020-01-OA-003
cd 2020-01-OA-003
julia --project=. -e 'import Pkg; Pkg.instantiate()'
julia --project=. paper_example.jl
```
