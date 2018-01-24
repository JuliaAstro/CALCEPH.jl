using CALCEPH
using Base.Test

# NAIF ID tests

for (name,id) ∈ NaifId.id
    @test name ∈ NaifId.names[id]
end

for (id,names) ∈ NaifId.names
    for name ∈ names
       @test NaifId.id[name] == id
   end
end

@test NaifId.id[:ssb] == NaifId.id[:solar_system_barycenter] == 0
@test NaifId.id[:sun] == 10
@test NaifId.id[:mercury_barycenter] == 1
@test NaifId.id[:mercury] == 199
@test NaifId.id[:venus_barycenter] == 2
@test NaifId.id[:venus] == 299
@test NaifId.id[:emb] == NaifId.id[:earth_barycenter] == 3
@test NaifId.id[:moon] == 301
@test NaifId.id[:earth] == 399
@test NaifId.id[:mars_barycenter] == 4
@test NaifId.id[:phobos] == 401
@test NaifId.id[:deimos] == 402
@test NaifId.id[:mars] == 499
@test NaifId.id[:jupiter_barycenter] == 5
@test NaifId.id[:io] == 501
@test NaifId.id[:europa] == 502
@test NaifId.id[:ganymede] == 503
@test NaifId.id[:callisto] == 504
@test NaifId.id[:jupiter] == 599
@test NaifId.id[:saturn_barycenter] == 6
@test NaifId.id[:titan] == 606
@test NaifId.id[:saturn] == 699
@test NaifId.id[:uranus_barycenter] == 7
@test NaifId.id[:uranus] == 799
@test NaifId.id[:neptune_barycenter] == 8
@test NaifId.id[:triton] == 801
@test NaifId.id[:neptune] == 899
@test NaifId.id[:pluto_barycenter] == 9
@test NaifId.id[:charon] == 901
@test NaifId.id[:pluto] == 999

@test_throws ErrorException CALCEPH.add!(NaifId,:jupiter,1)

testpath = joinpath(Pkg.dir("CALCEPH"), "test")
# check memory management
eph1 = CalcephEphem(joinpath(testpath,"example1.dat"))
eph2 = CalcephEphem([joinpath(testpath,"example1.bsp"),
                     joinpath(testpath,"example1.tpc")])


@test eph1.data != C_NULL
finalize(eph1)
@test eph1.data == C_NULL

@test eph2.data != C_NULL
finalize(eph2)
@test eph2.data == C_NULL
finalize(eph2)

# Opening invalid ephemeris
@test_throws ErrorException eph1 = CalcephEphem(String[])

# check constants
eph1 = CalcephEphem(joinpath(testpath,"example1.dat"))
eph2 = CalcephEphem([joinpath(testpath,"example1.bsp"),
                     joinpath(testpath,"example1.tpc")])

con1 = CalcephConstants(eph1)
con2 = CalcephConstants(eph2)

@test isa(con1,Dict{Symbol,Float64})
@test length(con1) == 402
@test con1[:EMRAT] ≈ 81.30056
@test isa(con2,Dict{Symbol,Float64})
@test length(con2) == 313
@test con2[:AU] ≈ 1.49597870696268e8

# Retrieving constants from closed ephemeris
finalize(eph2)
@test_throws ErrorException con2 = CalcephConstants(eph2)

# Retrieving constants from ephemeris with no constants
eph2 = CalcephEphem(joinpath(testpath,"example1.bsp"))
@test_throws ErrorException con2 = CalcephConstants(eph2)

inpop_files = [joinpath(testpath,"example1.dat")]
spk_files = [joinpath(testpath,"example1.bsp"),
             joinpath(testpath,"example1.tpc"),
             joinpath(testpath,"example1.tf"),
             joinpath(testpath,"example1.bpc"),
             joinpath(testpath,"example1spk_time.bsp")]

testfile = joinpath(testpath,"example1_tests.dat")

test_data = [
    (testfile,inpop_files,false),
    (testfile,spk_files,false),
    (testfile,inpop_files,true),
    (testfile,spk_files,true)
]

include("testfunction1.jl")

for (testFile,ephFiles,prefetch) in test_data
      testFunction1(testFile,ephFiles,prefetch)
end
