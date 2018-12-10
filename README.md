[![Build Status](https://travis-ci.org/bgodard/CALCEPH.jl.svg?branch=master)](https://travis-ci.org/bgodard/CALCEPH.jl)
[![AppVoyer](https://ci.appveyor.com/api/projects/status/24rxwncnrij2o0co?svg=true)](https://ci.appveyor.com/project/bgodard/calceph-jl)
[![Coverage Status](https://coveralls.io/repos/bgodard/CALCEPH.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/bgodard/CALCEPH.jl?branch=master)
[![codecov.io](http://codecov.io/github/bgodard/CALCEPH.jl/coverage.svg?branch=master)](http://codecov.io/github/bgodard/CALCEPH.jl?branch=master)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://bgodard.github.io/CALCEPH.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://bgodard.github.io/CALCEPH.jl/latest)

This is a julia wrapper for [CALCEPH](https://www.imcce.fr/inpop/calceph/) a C library for reading planetary ephemeris files, such as [INPOPxx](https://www.imcce.fr/inpop), JPL DExxx and SPICE ephemeris files.

[CALCEPH](https://www.imcce.fr/inpop/calceph/) C library is developped by [IMCCE](https://www.imcce.fr/).

# Quick start

In the Julia interpreter, run:

```julia
Pkg.add("CALCEPH")
using CALCEPH

# ephemeris kernels can be downloaded from many different sources
download("ftp://ftp.imcce.fr/pub/ephem/planets/inpop13c/inpop13c_TDB_m100_p100_tt.dat","planets.dat")
# WARNING this file is huge (Jupiter Moons ephemeris)
# download("https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup310.bsp","jupiter_system.bsp")

# create an ephemeris context
eph = Ephem("planets.dat")
# from multiple files
# eph = Ephem(["planets.dat","jupiter_system.bsp"])

# prefetch ephemeris files data to main memory for faster access
prefetch(eph)

# retrieve constants from ephemeris as a dictionary
con = constants(eph)
# list the constants
keys(con)
# get the sun J2
J2sun = con[:J2SUN]

# retrieve the position, velocity and acceleration of Earth (geocenter) relative
# to the Earth-Moon system barycenter in kilometers, kilometers per second and
# kilometers per second square at JD= 2451624.5 TDB timescale
# for best accuracy the first time argument should be the integer part and the
# delta the fractional part
# when using NAIF identification numbers, useNaifId has to be added to
# the units argument.
pva=compute(eph,2451624.0,0.5,naifId.id[:earth],naifId.id[:emb],
                        useNaifId+unitKM+unitSec,2)
position=pva[1:3]
velocity=pva[4:6]
acceleration=pva[7:end]

# what is the NAIF identification number for Deimos
id_deimos = naifId.id[:deimos]

# what does NAIF ID 0 correspond to?
names_0 = naifId.names[0]

```

# Why use CALCEPH?
CALCEPH functionality is also provided by [NAIF SPICE Toolkit](https://naif.jpl.nasa.gov/naif/toolkit.html). However CALCEPH has several advantages over the SPICE toolkit:
- It is faster at computing ephemeris data.
- It can handle multiple ephemeris contexts whereas the SPICE toolkit cannot.
- It is thread safe (if using one context per thread) whereas the SPICE toolkit is not.
- It can compute higher order derivatives (acceleration and jerk) approximation using differentiation of the interpolation polynomials.
- Its ephemeris computation interface expects the time separated in two double precision floating point numbers (the SPICE toolkit interface only use one double precision floating point number to specify an epoch). This can be used to achieve higher precision in timetag (this can have a significant impact when modeling Doppler observations from a deep space probe).
- It is distributed as a single cross platform source making it easy to integrate in other projects whereas the SPICE toolkit is distributed one source per platform.

But CALCEPH does not support all functions of the SPICE toolkit. If you need more functionalities [SPICE.jl](https://github.com/JuliaAstrodynamics/SPICE.jl) is a Julia wrapper for the SPICE toolkit.
