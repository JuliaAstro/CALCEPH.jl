


"
    CalcephCompute(eph,JD0,time,target,center)

Compute position (in AU) and velocity (in AU per day) of target with respect to
center at epoch JD0+time. This routine does not support the NAIF numbering
scheme. For the NAIF numbering scheme, use CalcephComputeUnit or
CalcephComputeOrder, with passing CalcephUseNAIFId in the unit argument.

# Arguments
- `JD0::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Int`: The body or reference point whose coordinates are required.
- `center::Int`: The origin of the coordinate system.

The possible values for target and center are :
* 1 : Mercury Barycenter
* 2 : Venus Barycenter
* 3 : Earth
* 4 : Mars Barycenter
* 5 : Jupiter Barycenter
* 6 : Saturn Barycenter
* 7 : Uranus Barycenter
* 8 : Neptune Barycenter
* 9 : Pluto Barycenter
* 10    : Moon
* 11    : Sun
* 12    : Solar Sytem barycenter
* 13    : Earth-moon barycenter
* 15    : Librations
* 16    : TT-TDB
* 17    : TCG-TCB
* asteroid number + CALCEPH_ASTEROID    : asteroid

"
function CalcephCompute(eph::CalcephEphem,JD0::Float64,time::Float64,
   target::Int64,center::Int64)
    if (eph.data == C_NULL)
       error("Ephemeris object is not propely initialized.")
    end
    result = Array{Float64,1}(6)
    stat = ccall((:calceph_compute, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Ref{Cdouble}),
    eph.data,JD0,time,target,center,result)
    if (stat == 0)
       error("Unable to compute ephemeris!")
    end
    return result
end

"
    CalcephComputeUnit(eph,JD0,time,target,center,unit)

Compute position and velocity of target with respect to center
at epoch JD0+time.

# Arguments
- `JD0::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Int`: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.
- `center::Int`: The origin of the coordinate system. The numbering system depends on the parameter unit.
- `unit::Int` : The units of the result. This integer is a sum of some unit constants (CalcephUnit*) and/or the constant CalcephUseNaifId. If the unit contains CalcephUseNaifId, the NAIF identification numbering system is used for the target and the center (see module NaifId). If the unit does not contain CalcephUseNaifId, the old number system is used for the target and the center (see the list in the documentation of function CalcephCompute).

"
function CalcephComputeUnit(eph::CalcephEphem,JD0::Float64,time::Float64,
   target::Int64,center::Int64,unit::Int64)
    if (eph.data == C_NULL)
       error("Ephemeris object is not propely initialized.")
    end
    result = Array{Float64,1}(6)
    stat = ccall((:calceph_compute_unit, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Cint,Ref{Cdouble}),
    eph.data,JD0,time,target,center,unit,result)
    if (stat == 0)
       error("Unable to compute ephemeris!")
    end
    return result
end

"
    CalcephComputeOrder(eph,JD0,time,target,center,unit,order)

Compute position and derivatives up to order of target with respect to center
at epoch JD0+time.

# Arguments
- `JD0::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Int`: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.
- `center::Int`: The origin of the coordinate system. The numbering system depends on the parameter unit.
- `unit::Int` : The units of the result. This integer is a sum of some unit constants (CalcephUnit*) and/or the constant CalcephUseNaifId. If the unit contains CalcephUseNaifId, the NAIF identification numbering system is used for the target and the center (see module NaifId). If the unit does not contain CalcephUseNaifId, the old number system is used for the target and the center (see the list in the documentation of function CalcephCompute).
- `order::Int` : The order of derivatives
    * 0: only the position is computed.
    * 1: only the position and velocity are computed.
    * 2: only the position, velocity and acceleration are computed.
    * 3: the position, velocity and acceleration and jerk are computed.

If order equals to 1, the behavior of CalcephComputeOrder is the same as that of CalcephComputeUnit.

"
function CalcephComputeOrder(eph::CalcephEphem,JD0::Float64,time::Float64,
   target::Int64,center::Int64,unit::Int64,order::Int64)
    if (eph.data == C_NULL)
       error("Ephemeris object is not propely initialized.")
    end
    if (order<0) || (order>3)
      error("Order must be between 0 and 3.")
    end
    result = Array{Float64,1}(3+3order)
    stat = ccall((:calceph_compute_order, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Cint,Cint,Ref{Cdouble}),
    eph.data,JD0,time,target,center,unit,order,result)
    if (stat == 0)
       error("Unable to compute ephemeris!")
    end
    return result
end
