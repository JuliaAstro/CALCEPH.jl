using CALCEPH
using Base.Test

# NAIF ID tests

for (name,id) ∈ NaifId.ids
    @test name ∈ NaifId.names[id]
end

for (id,names) ∈ NaifId.names
    for name ∈ names
       @test NaifId.ids[name] == id
   end
end

@test NaifId.ids[:ssb] == NaifId.ids[:solar_system_barycenter] == 0
@test NaifId.ids[:sun] == 10
@test NaifId.ids[:mercury_barycenter] == 1
@test NaifId.ids[:mercury] == 199
@test NaifId.ids[:venus_barycenter] == 2
@test NaifId.ids[:venus] == 299
@test NaifId.ids[:emb] == NaifId.ids[:earth_barycenter] == 3
@test NaifId.ids[:moon] == 301
@test NaifId.ids[:earth] == 399
@test NaifId.ids[:mars_barycenter] == 4
@test NaifId.ids[:phobos] == 401
@test NaifId.ids[:deimos] == 402
@test NaifId.ids[:mars] == 499
@test NaifId.ids[:jupiter_barycenter] == 5
@test NaifId.ids[:io] == 501
@test NaifId.ids[:europa] == 502
@test NaifId.ids[:ganymede] == 503
@test NaifId.ids[:callisto] == 504
@test NaifId.ids[:jupiter] == 599
@test NaifId.ids[:saturn_barycenter] == 6
@test NaifId.ids[:titan] == 606
@test NaifId.ids[:saturn] == 699
@test NaifId.ids[:uranus_barycenter] == 7
@test NaifId.ids[:uranus] == 799
@test NaifId.ids[:neptune_barycenter] == 8
@test NaifId.ids[:triton] == 801
@test NaifId.ids[:neptune] == 899
@test NaifId.ids[:pluto_barycenter] == 9
@test NaifId.ids[:charon] == 901
@test NaifId.ids[:pluto] == 999

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


inpop_files = [joinpath(testpath,"example1.dat")]
spk_files = [joinpath(testpath,"example1.bsp"),
             joinpath(testpath,"example1.tpc"),
             joinpath(testpath,"example1.tf"),
             joinpath(testpath,"example1.bpc"),
             joinpath(testpath,"example1spk_time.bsp")]

test_data = [
    ("test/example1_tests.dat",inpop_files,false),
    ("test/example1_tests.dat",spk_files,false),
    ("test/example1_tests.dat",inpop_files,true),
    ("test/example1_tests.dat",spk_files,true)
]

include("testfunction1.jl")

for (testFile,ephFiles,prefetch) in test_data
      testFunction1(testFile,ephFiles,prefetch)
end
