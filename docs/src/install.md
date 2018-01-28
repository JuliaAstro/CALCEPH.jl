# Prerequisites

## Linux and OS X

If you do not have the [CALCEPH C library](https://www.imcce.fr/recherche/equipes/asd/calceph/) installed, the installation process will fetch it and try to build it, in which case you need a working C compiler.

## Windows

Install first the [CALCEPH C library](https://www.imcce.fr/recherche/equipes/asd/calceph/).

# Retrieving and installing CALCEPH.jl

In your favorite Julia interpreter, run:

```julia
Pkg.clone("https://github.com/bgodard/CALCEPH.jl")
```

To start using it:

```julia
using CALCEPH
```
