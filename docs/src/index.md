
CALCEPH.jl is a julia wrapper for [CALCEPH](https://www.imcce.fr/recherche/equipes/asd/calceph/) a C library for reading planetary ephemeris files, such INPOPxx, JPL DExxx and SPICE ephemeris files.

[CALCEPH](https://www.imcce.fr/recherche/equipes/asd/calceph/) C library is developped by [IMCCE](https://www.imcce.fr/).

# Quick start

In your favorite Julia interpreter, run:

```julia
Pkg.clone("https://github.com/bgodard/CALCEPH.jl")
using CALCEPH

# ephemeris kernels can be downloaded from many different sources
download("ftp://ftp.imcce.fr/pub/ephem/planets/inpop13c/inpop13c_TDB_m100_p100_tt.dat","planets.dat")
# WARNING this file is huge (Jupiter Moons ephemeris)
# download("https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup310.bsp","jupiter_system.bsp")

# create an ephemeris context
eph = CalcephEphem("planets.dat")
# from multiple files
# eph = CalcephEphem("planets.dat","jupiter_system.bsp")

# prefetch ephemeris files data to main memory for faster access
CalcephPrefetch(eph)

# retrieve constants from ephemeris as a dictionary
constants = CalcephConstants(eph)
# list the constants
keys(constants)
# get the sun J2
J2sun = constants[:J2SUN]

# retrieve the position, velocity and acceleration of Earth (geocenter) relative to the Earth-Moon system barycenter in kilometers, kilometers per second and kilometers per second square at JD= 2451624.5 TDB timescale
# for best accuracy the first time argument should be the integer part and the delta the fractional part
# when using NAIF identification numbers, CalcephUseNaifId has to be added to the units argument
pva=CalcephComputeOrder(eph,2451624.0,0.5,NaifId.id[:earth],NaifId.id[:emb],
                                    CalcephUseNaifId+CalcephUnitKM+CalcephUnitSec,2)
position=pva[1:3]
velocity=pva[4:6]
acceleration=pva[7:end]

# what is the NAIF identification number for Deimos
id_deimos = NaifId.id[:deimos]

# what does NAIF ID 0 correspond to?
names_0 = NaifId.names[0]

```

# Why use CALCEPH?
CALCEPH functionality is also provided by [NAIF SPICE Toolkit](https://naif.jpl.nasa.gov/naif/toolkit.html). However CALCEPH has several advantages over SPICE:
- It is faster at computing ephemeris data.
- It can handle multiple ephemeris context whereas SPICE cannot.
- It is thread safe (if using one context per thread) whereas SPICE is not.
- It can compute higher order derivatives (acceleration and jerk) approximation using differentiation of the interpolation polynomials.
- Its ephemeris computation interface expects the time separated in two double precision numbers (SPICE interface only has one). This can be used to achieve higher
precision in timetag (this can have a significant impact when modeling Doppler observations from a deep space probe).
- It is distributed as a single cross platform source making it easy to integrate in other projects whereas SPICE is distributed one source per platform.

But CALCEPH does not support all functions of the SPICE Toolkit. If you need more functionalities [SPICE.jl](https://github.com/JuliaAstrodynamics/SPICE.jl) is a Julia wrapper for SPICE.
