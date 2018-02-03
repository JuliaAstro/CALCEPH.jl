
const CalcephMaxConstName = 33
"
   CalcephConstants(eph)

   Retrieve the constants stored in the ephemeris associated to handle eph as a dictionary

"
function CalcephConstants(eph::CalcephEphem)
    res = Dict{Symbol,Float64}()
    @CalcephCheckPointer eph.data "Ephemeris is not properly initialized!"
    NC::Int = ccall((:calceph_getconstantcount , libcalceph), Cint,
    (Ptr{Void},),eph.data)
    if (NC == 0)
       throw(CalcephException("Unable to get number of constants!"))
    end
    value = Ref{Cdouble}(0.0)
    name = Vector{UInt8}(CalcephMaxConstName)
    for i=1:NC
       stat = ccall((:calceph_getconstantindex , libcalceph), Cint,
                  (Ptr{Void},Cint,Ptr{UInt8},Ref{Cdouble}),
                  eph.data, i ,name ,value)
       if (stat!=0)
          res[Symbol(strip(unsafe_string(pointer(name))))] = value[]
       end
    end

    return res
end
