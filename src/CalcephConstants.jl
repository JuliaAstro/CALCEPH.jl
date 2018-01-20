
const CalcephMaxConstName = 33
"
   CalcephConstants(e)

   Retrieve the constants stored in the ephemeris associated to handle e as a dictionary

"
function CalcephConstants(e::CalcephEphem)
    res = Dict{Symbol,Float64}()
    if (e.data == C_NULL)
       error("Ephemeris object is not propely initialized.")
    end
    NC::Int = ccall((:calceph_getconstantcount , libcalceph), Cint,
    (Ptr{Void},),e.data)
    if (NC == 0)
       error("Unable to get number of constants!")
    end
    for i=1:NC
       value = Ref{Cdouble}(0.0)
       name = Vector{UInt8}(CalcephMaxConstName)
       stat = ccall((:calceph_getconstantindex , libcalceph), Cint,
                  (Ptr{Void},Cint,Ptr{UInt8},Ref{Cdouble}),
                  e.data, i ,name ,value)

                  res[Symbol(strip(unsafe_string(pointer(name))))] = value[]
    end

    return res
end
