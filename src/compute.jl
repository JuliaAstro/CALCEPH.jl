"""
    compute(eph,jd0,time,target,center)

Compute position and velocity of target with respect to center at epoch
jd0+time. This method does not support the NAIF numbering scheme.
To get the best precision for the interpolation, the time is splitted in two
floating-point numbers. The argument jd0 should be an integer and time should
be a fraction of the day. But you may call this function with time=0 and jd0,
the desired time, if you don't take care about precision.

This method does not support the NAIF body identification scheme.

Output units are:
* AU and AU/day for position and velocity
* rad and rad/day for librations
* second and unitless for time ephemeris and time ephemeris rate

# Arguments
- `jd0::Float64`: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Integer`: The body or reference point whose coordinates are required.
- `center::Integer`: The origin of the coordinate system.

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
* asteroid number + 2000000    : asteroid

"""
function compute(eph::Ephem,jd0::Float64,time::Float64,
   target::Integer,center::Integer)
    @_checkPointer eph.data "Ephemeris is not properly initialized!"
    result = Array{Float64,1}(6)
    stat = ccall((:calceph_compute, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Ref{Cdouble}),
    eph.data,jd0,time,target,center,result)
    @_checkStatus stat "Unable to compute ephemeris"
    return result
end

"""
    compute(eph,jd0,time,target,center,unit)

Compute position and velocity of target with respect to center
at epoch jd0+time.
To get the best precision for the interpolation, the time is splitted in two
floating-point numbers. The argument jd0 should be an integer and time should
be a fraction of the day. But you may call this function with time=0 and jd0,
the desired time, if you don't take care about precision.

# Arguments
- `jd0::Float64`: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Integer`: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.
- `center::Integer`: The origin of the coordinate system. The numbering system depends on the parameter unit.
- `unit::Integer` : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center.

"""
function compute(eph::Ephem,jd0::Float64,time::Float64,
   target::Integer,center::Integer,unit::Integer)
    @_checkPointer eph.data "Ephemeris is not properly initialized!"
    result = Array{Float64,1}(6)
    stat = ccall((:calceph_compute_unit, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Cint,Ref{Cdouble}),
    eph.data,jd0,time,target,center,unit,result)
    @_checkStatus stat "Unable to compute ephemeris"
    return result
end

"""
    compute(eph,jd0,time,target,center,unit,order)

Compute position and derivatives up to order of target with respect to center
at epoch jd0+time.
To get the best precision for the interpolation, the time is splitted in two
floating-point numbers. The argument jd0 should be an integer and time should
be a fraction of the day. But you may call this function with time=0 and jd0,
the desired time, if you don't take care about precision.

# Arguments
- `jd0::Float64`: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `time::Float64`: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)
- `target::Integer`: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.
- `center::Integer`: The origin of the coordinate system. The numbering system depends on the parameter unit.
- `unit::Integer` : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center.
- `order::Integer` : The order of derivatives
    * 0: only the position is computed.
    * 1: only the position and velocity are computed.
    * 2: only the position, velocity and acceleration are computed.
    * 3: the position, velocity and acceleration and jerk are computed.

"""
function compute(eph::Ephem,jd0::Float64,time::Float64,
   target::Integer,center::Integer,unit::Integer,order::Integer)
    @_checkPointer eph.data "Ephemeris is not properly initialized!"
    @_checkOrder order
    result = Array{Float64,1}(3+3order)
    stat = ccall((:calceph_compute_order, libcalceph), Cint,
    (Ptr{Void},Cdouble,Cdouble,Cint,Cint,Cint,Cint,Ref{Cdouble}),
    eph.data,jd0,time,target,center,unit,order,result)
    @_checkStatus stat "Unable to compute ephemeris"
    return result
end
