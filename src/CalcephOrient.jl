"
    CalcephOrientUnit(eph,JD0,time,target,unit)

Compute Euler angle and derivatives for the orientation of target at epoch JD0+time.
To get the best precision for the interpolation, the time is splitted in
two floating-point numbers.

# Arguments
- `JD0::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Int`: The body or reference point whose orientation is required. The numbering system depends on the parameter unit.
- `unit::Int` : The units of the result. This integer is a sum of some unit constants (CalcephUnit*) and/or the constant CalcephUseNaifId. If the unit contains CalcephUseNaifId, the NAIF identification numbering system is used for the target and the center (see module NaifId). If the unit does not contain CalcephUseNaifId, the old number system is used for the target and the center (see the list in the documentation of function CalcephCompute). The angles are expressed in radians if unit contains CalcephUnitRad.

"
function CalcephOrientUnit(eph::CalcephEphem,JD0::Float64,time::Float64,
   target::Int64,unit::Int64)
    if (eph.data == C_NULL)
       error("Ephemeris object is not propely initialized.")
    end
    result = Array{Float64,1}(6)
    stat = ccall((:calceph_orient_unit, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Ref{Cdouble}),
    eph.data,JD0,time,target,unit,result)
    if (stat == 0)
       error("Unable to compute ephemeris!")
    end
    return result
end

"
    CalcephOrientOrder(eph,JD0,time,target,unit,order)

Compute Euler angle and derivatives up to order for the orientation of target at epoch JD0+time.
To get the best precision for the interpolation, the time is splitted in
two floating-point numbers.

# Arguments
- `JD0::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: JD0+time must be equal to the Julian date for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Int`: The body or reference point whose orientation is required. The numbering system depends on the parameter unit.
- `unit::Int` : The units of the result. This integer is a sum of some unit constants (CalcephUnit*) and/or the constant CalcephUseNaifId. If the unit contains CalcephUseNaifId, the NAIF identification numbering system is used for the target and the center (see module NaifId). If the unit does not contain CalcephUseNaifId, the old number system is used for the target and the center (see the list in the documentation of function CalcephCompute).
- `order::Int` : The order of derivatives
    * 0: only the angles are computed.
    * 1: only the angles and 1st derivatives are computed.
    * 2: only the angles, the 1st derivatives and 2nd derivatives are computed.
    * 3: the angles, the 1st derivatives, 2nd derivatives and 3rd derivatives are computed.

If order equals to 1, the behavior of CalcephOrientOrder is the same as that of CalcephOrientUnit.

"
function CalcephOrientOrder(eph::CalcephEphem,JD0::Float64,time::Float64,
   target::Int64,unit::Int64,order::Int64)
    if (eph.data == C_NULL)
       error("Ephemeris object is not propely initialized.")
    end
    if (order<0) || (order>3)
      error("Order must be between 0 and 3.")
    end
    result = Array{Float64,1}(3+3order)
    stat = ccall((:calceph_orient_order, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Cint,Ref{Cdouble}),
    eph.data,JD0,time,target,unit,order,result)
    if (stat == 0)
       error("Unable to compute ephemeris!")
    end
    return result
end
