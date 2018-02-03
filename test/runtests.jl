using CALCEPH
using Base.Test

testpath = joinpath(Pkg.dir("CALCEPH"), "test")

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

# test error case: changing name->id mapping
@test_throws CalcephException CALCEPH.add!(NaifId,:jupiter,1)
# test error case: parsing wrongly formatted body id input file
bid = CALCEPH.BodyId()
@test_throws CalcephException CALCEPH.loadData!(bid,joinpath(testpath,"badIds.txt"))

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
CALCEPH.CalcephEphemDestructor(eph2)

# Opening invalid ephemeris
@test_throws CalcephException eph1 = CalcephEphem(String[])

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
@test_throws CalcephException con2 = CalcephConstants(eph2)

# Retrieving constants from ephemeris with no constants
eph2 = CalcephEphem(joinpath(testpath,"example1.bsp"))
@test_throws CalcephException con2 = CalcephConstants(eph2)

# test CalcephCompute*
# test data and thresholds from CALCEPH C library tests
inpop_files = [joinpath(testpath,"example1.dat")]
spk_files = [joinpath(testpath,"example1.bsp"),
             joinpath(testpath,"example1.tpc"),
             joinpath(testpath,"example1.tf"),
             joinpath(testpath,"example1.bpc"),
             joinpath(testpath,"example1spk_time.bsp")]

testfile = joinpath(testpath,"example1_tests.dat")

test_data = [
    (inpop_files,false),
    (spk_files,false),
    (inpop_files,true),
    (spk_files,true)
]

include("testfunction1.jl")

for (ephFiles,prefetch) in test_data
    testFunction1(testfile,ephFiles,prefetch)
end

testfile2 = joinpath(testpath,"example1_tests_naifid.dat")

include("testfunction2.jl")

for (ephFiles,prefetch) in test_data
    testFunction2(testfile,testfile2,ephFiles,prefetch)
end

# test error case wrong order
eph1 = CalcephEphem(joinpath(testpath,"example1.bsp"))
@test_throws CalcephException CalcephComputeOrder(eph1,0.0,0.0,1,0,0,4)
@test_throws CalcephException CalcephComputeOrder(eph1,0.0,0.0,1,0,0,-1)

# test error case:
@test_throws CalcephException CalcephComputeUnit(eph1,0.0,0.0,-144,0,0)


# Five-Point Stencil

f(x)=x^8
@test_throws ErrorException CALCEPH.FivePointStencil(f,1.5,5,0.001)
@test_throws ErrorException CALCEPH.FivePointStencil(f,1.5,-1,0.001)
@test_throws ErrorException CALCEPH.FivePointStencil(f,1.5,4,0.0)
val = CALCEPH.FivePointStencil(f,1.5,4,0.001)
ref = [25.62890625,136.6875,637.875,2551.5,8505.0]
@test ref[1] ≈ val[1] atol=1e-10
@test ref[2] ≈ val[2] atol=1e-8
@test ref[3] ≈ val[3] atol=1e-5
@test ref[4] ≈ val[4] atol=1e-2
@test ref[5] ≈ val[5] atol=1e-2
