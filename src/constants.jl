
const _maxConstName = 33
"""
   constants(eph)

   Retrieve the constants stored in the ephemeris associated to handle eph as a dictionary

"""
function constants(eph::Ephem)
    res = Dict{Symbol,Float64}()
    @_checkPointer eph.data "Ephemeris is not properly initialized!"
    NC::Int = ccall((:calceph_getconstantcount , libcalceph), Cint,
    (Ptr{Void},),eph.data)
    if (NC == 0)
       throw(CALCEPHException("Unable to get number of constants!"))
    end
    value = Ref{Cdouble}(0.0)
    name = Vector{UInt8}(_maxConstName)
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
