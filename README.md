# CALCEPH.jl

[![Build Status](https://travis-ci.org/bgodard/CALCEPH.jl.svg?branch=master)](https://travis-ci.org/bgodard/CALCEPH.jl)
[![Coverage Status](https://coveralls.io/repos/bgodard/CALCEPH.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/bgodard/CALCEPH.jl?branch=master)
[![codecov.io](http://codecov.io/github/bgodard/CALCEPH.jl/coverage.svg?branch=master)](http://codecov.io/github/bgodard/CALCEPH.jl?branch=master)

This is a julia wrapper for CALCEPH a C library for reading planetary ephemeris files, such INPOPxx, JPL DExxx and SPICE ephemeris files.

[CALCEPH](https://www.imcce.fr/recherche/equipes/asd/calceph/) C library is developped by IMCCE.

## Why use CALCEPH?
CALCEPH functionality is also provided by [NAIF SPICE Toolkit](https://naif.jpl.nasa.gov/naif/toolkit.html). However CALCEPH has several advantages over SPICE:
- It is faster at computing ephemeris data.
- It can handle multiple ephemeris context whereas SPICE cannot.
- It is thread safe (if using one context per thread) whereas SPICE is not.
- It can compute higher order derivatives (acceleration and jerk) approximation using differentiation of the interpolation polynomials.
- Its ephemeris computation interface expects the time separated in two double precision numbers (SPICE interface only has one). This can be used to achieve higher
precision in timetag (this can have a significant impact when modeling Doppler observations from a deep space probe).
- It is distributed as a single cross platform source making it easy to integrate in other projects whereas SPICE is distributed one source per platform.

But CALCEPH does not support all functions of the SPICE Toolkit. If you need more functionalities [SPICE.jl](https://github.com/JuliaAstrodynamics/SPICE.jl) is a Julia wrapper for SPICE.
