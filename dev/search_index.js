var documenterSearchIndex = {"docs": [

{
    "location": "compute/#CALCEPH.compute",
    "page": "-",
    "title": "CALCEPH.compute",
    "category": "function",
    "text": "compute(eph,jd0,time,target,center)\n\nCompute position and velocity of target with respect to center at epoch jd0+time. This method does not support the NAIF numbering scheme. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nThis method does not support the NAIF body identification scheme.\n\nOutput units are:\n\nAU and AU/day for position and velocity\nrad and rad/day for librations\nsecond and unitless for time ephemeris and time ephemeris rate\n\nArguments\n\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body or reference point whose coordinates are required.\ncenter::Integer: The origin of the coordinate system.\n\nThe possible values for target and center are :\n\n1 : Mercury Barycenter\n2 : Venus Barycenter\n3 : Earth\n4 : Mars Barycenter\n5 : Jupiter Barycenter\n6 : Saturn Barycenter\n7 : Uranus Barycenter\n8 : Neptune Barycenter\n9 : Pluto Barycenter\n10    : Moon\n11    : Sun\n12    : Solar Sytem barycenter\n13    : Earth-moon barycenter\n14    : Nutation angles\n15    : Librations\n16    : TT-TDB\n17    : TCG-TCB\nasteroid number + 2000000    : asteroid\n\n\n\n\n\ncompute(eph,jd0,time,target,center,unit)\n\nCompute position and velocity of target with respect to center at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.\ncenter::Integer: The origin of the coordinate system. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center.\n\n\n\n\n\ncompute(eph,jd0,time,target,center,unit,order)\n\nCompute position and derivatives up to order of target with respect to center at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.\ncenter::Integer: The origin of the coordinate system. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center.\norder::Integer : The order of derivatives\n0: only the position is computed.\n1: only the position and velocity are computed.\n2: only the position, velocity and acceleration are computed.\n3: the position, velocity and acceleration and jerk are computed.\n\n\n\n\n\n"
},

{
    "location": "compute/#CALCEPH.unsafe_compute!",
    "page": "-",
    "title": "CALCEPH.unsafe_compute!",
    "category": "function",
    "text": "unsafe_compute!(eph,jd0,time,target,center)\n\nIn place version of the compute function. Does not perform any checks! Compute position and velocity of target with respect to center at epoch jd0+time. This method does not support the NAIF numbering scheme. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nThis method does not support the NAIF body identification scheme.\n\nOutput units are:\n\nAU and AU/day for position and velocity\nrad and rad/day for librations\nsecond and unitless for time ephemeris and time ephemeris rate\n\nArguments\n\nresult: container for result. It is not checked if it is sufficiently large enough!\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body or reference point whose coordinates are required.\ncenter::Integer: The origin of the coordinate system.\n\nReturn:\n\nstatus integer from CALCEPH: 0 if an error occured\n\nThe possible values for target and center are :\n\n1 : Mercury Barycenter\n2 : Venus Barycenter\n3 : Earth\n4 : Mars Barycenter\n5 : Jupiter Barycenter\n6 : Saturn Barycenter\n7 : Uranus Barycenter\n8 : Neptune Barycenter\n9 : Pluto Barycenter\n10    : Moon\n11    : Sun\n12    : Solar Sytem barycenter\n13    : Earth-moon barycenter\n14    : Nutation angles\n15    : Librations\n16    : TT-TDB\n17    : TCG-TCB\nasteroid number + 2000000    : asteroid\n\n\n\n\n\nunsafe_compute!(result,eph,jd0,time,target,center,unit)\n\nIn place version of the compute function. Does not perform any checks! Compute position and velocity of target with respect to center at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\nresult: container for result. It is not checked if it is sufficiently large enough!\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.\ncenter::Integer: The origin of the coordinate system. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center.\n\nReturn:\n\nstatus integer from CALCEPH: 0 if an error occured\n\n\n\n\n\nunsafe_compute!(result,eph,jd0,time,target,center,unit,order)\n\nIn place version of the compute function. Does not perform any checks! Compute position and derivatives up to order of target with respect to center at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\nresult: container for result. It is not checked if it is sufficiently large enough!\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body or reference point whose coordinates are required. The numbering system depends on the parameter unit.\ncenter::Integer: The origin of the coordinate system. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center.\norder::Integer : The order of derivatives\n0: only the position is computed.\n1: only the position and velocity are computed.\n2: only the position, velocity and acceleration are computed.\n3: the position, velocity and acceleration and jerk are computed.\n\nReturn:\n\nstatus integer from CALCEPH: 0 if an error occured\n\n\n\n\n\n"
},

{
    "location": "compute/#CALCEPH.orient",
    "page": "-",
    "title": "CALCEPH.orient",
    "category": "function",
    "text": "orient(eph,jd0,time,target,unit)\n\nCompute Euler angles and first derivative for the orientation of target at epoch jd0+time. To get the best precision for the interpolation, the time is split in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose orientation is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute). The angles are expressed in radians if unit contains unitRad. If the unit contains outputNutationAngles, the nutation angles are computed rather than the Euler angles.\n\n\n\n\n\norient(eph,jd0,time,target,unit,order)\n\nCompute Euler angles and derivatives up to order for the orientation of target at epoch jd0+time. To get the best precision for the interpolation, the time is split in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose orientation is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute). If the unit contains outputNutationAngles, the nutation angles are computed rather than the Euler angles.\norder::Integer : The order of derivatives\n0: only the angles are computed.\n1: only the angles and 1st derivatives are computed.\n2: only the angles, the 1st derivatives and 2nd derivatives are computed.\n3: the angles, the 1st derivatives, 2nd derivatives and 3rd derivatives are computed.\n\n\n\n\n\n"
},

{
    "location": "compute/#CALCEPH.unsafe_orient!",
    "page": "-",
    "title": "CALCEPH.unsafe_orient!",
    "category": "function",
    "text": "unsafe_orient!(result,eph,jd0,time,target,unit)\n\nIn place version of the orient function. Does not perform any checks! Compute Euler angles and first derivative for the orientation of target at epoch jd0+time. To get the best precision for the interpolation, the time is split in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\nresult: container for result. It is not checked if it is sufficiently large enough!\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose orientation is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute). If the unit contains outputNutationAngles, the nutation angles are computed rather than the Euler angles.\n\nReturn:\n\nstatus integer from CALCEPH: 0 if an error occured\n\n\n\n\n\nunsafe_orient!(result,eph,jd0,time,target,unit,order)\n\nIn place version of the orient function. Does not perform any checks! Compute Euler angles and derivatives up to order for the orientation of target at epoch jd0+time. To get the best precision for the interpolation, the time is split in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\nresult: container for result. It is not checked if it is sufficiently large enough!\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose orientation is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute). If the unit contains outputNutationAngles, the nutation angles are computed rather than the Euler angles.\norder::Integer : The order of derivatives\n0: only the angles are computed.\n1: only the angles and 1st derivatives are computed.\n2: only the angles, the 1st derivatives and 2nd derivatives are computed.\n3: the angles, the 1st derivatives, 2nd derivatives and 3rd derivatives are computed.\nReturn:\nstatus integer from CALCEPH: 0 if an error occured\n\n\n\n\n\n"
},

{
    "location": "compute/#CALCEPH.rotAngMom",
    "page": "-",
    "title": "CALCEPH.rotAngMom",
    "category": "function",
    "text": "rotAngMom(eph,jd0,time,target,unit)\n\nCompute angular momentum due to rotation and first derivative of target at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose angular momentum is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute). The angles are expressed in radians if unit contains unitRad.\n\n\n\n\n\nrotAngMom(eph,jd0,time,target,unit,order)\n\nCompute angular momentum due to rotation and derivatives up to order of target at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose angular momentum is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute).\norder::Integer : The order of derivatives\n0: only the angles are computed.\n1: only the angles and 1st derivatives are computed.\n2: only the angles, the 1st derivatives and 2nd derivatives are computed.\n3: the angles, the 1st derivatives, 2nd derivatives and 3rd derivatives are computed.\n\n\n\n\n\n"
},

{
    "location": "compute/#CALCEPH.unsafe_rotAngMom!",
    "page": "-",
    "title": "CALCEPH.unsafe_rotAngMom!",
    "category": "function",
    "text": "unsafe_rotAngMom!(result,eph,jd0,time,target,unit)\n\nIn place version of the rotAngMom function. Does not perform any checks! Compute angular momentum due to rotation and first derivative of target at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\nresult: container for result. It is not checked if it is sufficiently large enough!\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose angular momentum is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute). The angles are expressed in radians if unit contains unitRad.\n\nReturn:\n\nstatus integer from CALCEPH: 0 if an error occured\n\n\n\n\n\nunsafe_rotAngMom!(result,eph,jd0,time,target,unit,order)\n\nIn place version of the rotAngMom function. Does not perform any checks! Compute angular momentum due to rotation and derivatives up to order of target at epoch jd0+time. To get the best precision for the interpolation, the time is splitted in two floating-point numbers. The argument jd0 should be an integer and time should be a fraction of the day. But you may call this function with time=0 and jd0, the desired time, if you don\'t take care about precision.\n\nArguments\n\nresult: container for result. It is not checked if it is sufficiently large enough!\neph: ephemeris\njd0::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntime::Float64: jd0+time must be equal to the Julian Day for the time coordinate corresponding to the ephemeris (usually TDB or TCB)\ntarget::Integer: The body whose angular momentum is required. The numbering system depends on the parameter unit.\nunit::Integer : The units of the result. This integer is a sum of some unit constants (unit*) and/or the constant useNaifId. If the unit contains useNaifId, the NAIF identification numbering system is used for the target and the center. If the unit does not contain useNaifId, the old number system is used for the target and the center (see the list in the documentation of function compute).\norder::Integer : The order of derivatives\n0: only the angles are computed.\n1: only the angles and 1st derivatives are computed.\n2: only the angles, the 1st derivatives and 2nd derivatives are computed.\n3: the angles, the 1st derivatives, 2nd derivatives and 3rd derivatives are computed.\nReturn:\nstatus integer from CALCEPH: 0 if an error occured\n\n\n\n\n\n"
},

{
    "location": "compute/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.compute\nCALCEPH.unsafe_compute!\nCALCEPH.orient\nCALCEPH.unsafe_orient!\nCALCEPH.rotAngMom\nCALCEPH.unsafe_rotAngMom!"
},

{
    "location": "constants/#CALCEPH.constants",
    "page": "-",
    "title": "CALCEPH.constants",
    "category": "function",
    "text": "constants(eph)\n\nRetrieve the constants stored in the ephemeris associated to handle eph as a dictionary\n\n\n\n\n\n"
},

{
    "location": "constants/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.constants"
},

{
    "location": "context/#CALCEPH.Ephem",
    "page": "-",
    "title": "CALCEPH.Ephem",
    "category": "type",
    "text": "Ephem\n\nEphemeris descriptor. Create with:\n\neph = Ephem(filename)\neph = Ephem([filename1,filename2...])\n\nThe ephemeris descriptor will be used to access the ephemeris and related   data stored in the specified files.\n\nBecause, Julia GC is lazy, you may want to free the memory managed by eph   before you get rid of the reference to eph with:\n\nfinalize(eph)\n\nor after by forcing the GC to run:\n\ngc()\n\n\n\n\n\n"
},

{
    "location": "context/#CALCEPH.prefetch",
    "page": "-",
    "title": "CALCEPH.prefetch",
    "category": "function",
    "text": "prefetch(eph)\n\nThis function prefetches to the main memory all files associated to the ephemeris descriptor eph.\n\n\n\n\n\n"
},

{
    "location": "context/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.Ephem\nCALCEPH.prefetch"
},

{
    "location": "errors/#CALCEPH.disableCustomHandler",
    "page": "-",
    "title": "CALCEPH.disableCustomHandler",
    "category": "function",
    "text": "disableCustomHandler()\n\nDisables the user custom error handler.\n\n\n\n\n\n"
},

{
    "location": "errors/#CALCEPH.setCustomHandler",
    "page": "-",
    "title": "CALCEPH.setCustomHandler",
    "category": "function",
    "text": "setCustomHandler(f::Function)\n\nSets the user custom error handler.\n\nArguments\n\nf: function taking a single argument of type String which will contain the CALCEPH error message. f should return Nothing.\n\nUse setCustomHandler(s->Nothing) to disable CALCEPH error messages printout to the console.\n\n\n\n\n\n"
},

{
    "location": "errors/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.disableCustomHandler\nCALCEPH.setCustomHandler"
},

{
    "location": "ids/#CALCEPH.BodyId",
    "page": "-",
    "title": "CALCEPH.BodyId",
    "category": "type",
    "text": "BodyId\n\nBody identifiers.\n\n\n\n\n\n"
},

{
    "location": "ids/#CALCEPH.add!",
    "page": "-",
    "title": "CALCEPH.add!",
    "category": "function",
    "text": "add!(bid,name,id)\n\nAdd a new mapping name->id into BodyId instance bid.\n\nExample:\n\n    using CALCEPH\n    bid=CALCEPH.BodyId()\n    CALCEPH.add!(bid,:tatooine,1000001)\n    CALCEPH.add!(bid,:dagobah,1000002)\n    CALCEPH.add!(bid,:endor,1000003)\n    CALCEPH.add!(bid,:deathstar,1000004)\n    CALCEPH.add!(bid,:endor_deathstar_system_barycenter,1000005)\n    CALCEPH.add!(bid,:edsb,1000005)\n\n# output\n\n\n\n\n\n\n"
},

{
    "location": "ids/#CALCEPH.loadData!",
    "page": "-",
    "title": "CALCEPH.loadData!",
    "category": "function",
    "text": "loadData!(bid,filename)\n\nLoad mapping (body name,body ID) from file into BodyId instance bid.   Names from the file are converted to lower case and have spaces replaced by   underscores before being converted to symbols/interned strings.\n\nExample file https://github.com/bgodard/CALCEPH.jl/blob/master/data/NaifIds.txt\n\n\n\n\n\n"
},

{
    "location": "ids/#CALCEPH.naifId",
    "page": "-",
    "title": "CALCEPH.naifId",
    "category": "constant",
    "text": "naifId\n\nNAIF identification numbers\n\nExamples:\n\njulia> using CALCEPH\n\njulia> naifId.id[:sun]\n10\n\njulia> naifId.id[:mars]\n499\n\njulia> naifId.names[0]\nSet(Symbol[:ssb, :solar_system_barycenter])\n\n\n\n\n\n\n"
},

{
    "location": "ids/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.BodyId\nCALCEPH.add!\nCALCEPH.loadData!\nCALCEPH.naifId"
},

{
    "location": "#",
    "page": "Quick start",
    "title": "Quick start",
    "category": "page",
    "text": "This is a julia wrapper for CALCEPH a C library for reading planetary ephemeris files, such as INPOPxx, JPL DExxx and SPICE ephemeris files.CALCEPH C library is developped by IMCCE."
},

{
    "location": "#Quick-start-1",
    "page": "Quick start",
    "title": "Quick start",
    "category": "section",
    "text": "In the Julia interpreter, run:Pkg.add(\"CALCEPH\")\nusing CALCEPH\n\n# ephemeris kernels can be downloaded from many different sources\ndownload(\"ftp://ftp.imcce.fr/pub/ephem/planets/inpop13c/inpop13c_TDB_m100_p100_tt.dat\",\"planets.dat\")\n# WARNING this file is huge (Jupiter Moons ephemeris)\n# download(\"https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup310.bsp\",\"jupiter_system.bsp\")\n\n# create an ephemeris context\neph = Ephem(\"planets.dat\")\n# from multiple files\n# eph = Ephem([\"planets.dat\",\"jupiter_system.bsp\"])\n\n# prefetch ephemeris files data to main memory for faster access\nprefetch(eph)\n\n# retrieve constants from ephemeris as a dictionary\ncon = constants(eph)\n# list the constants\nkeys(con)\n# get the sun J2\nJ2sun = con[:J2SUN]\n\n# retrieve the position, velocity and acceleration of Earth (geocenter) relative\n# to the Earth-Moon system barycenter in kilometers, kilometers per second and\n# kilometers per second square at JD= 2451624.5 TDB timescale\n# for best accuracy the first time argument should be the integer part and the\n# delta the fractional part\n# when using NAIF identification numbers, useNaifId has to be added to\n# the units argument.\npva=compute(eph,2451624.0,0.5,naifId.id[:earth],naifId.id[:emb],\n                        useNaifId+unitKM+unitSec,2)\nposition=pva[1:3]\nvelocity=pva[4:6]\nacceleration=pva[7:end]\n\n# what is the NAIF identification number for Deimos\nid_deimos = naifId.id[:deimos]\n\n# what does NAIF ID 0 correspond to?\nnames_0 = naifId.names[0]\n"
},

{
    "location": "#Why-use-CALCEPH?-1",
    "page": "Quick start",
    "title": "Why use CALCEPH?",
    "category": "section",
    "text": "CALCEPH functionality is also provided by NAIF SPICE Toolkit. However CALCEPH has several advantages over the SPICE toolkit:It is faster at computing ephemeris data.\nIt can handle multiple ephemeris contexts whereas the SPICE toolkit cannot.\nIt is thread safe (if using one context per thread) whereas the SPICE toolkit is not.\nIt can compute higher order derivatives (acceleration and jerk) approximation using differentiation of the interpolation polynomials.\nIts ephemeris computation interface expects the time separated in two double precision floating point numbers (the SPICE toolkit interface only use one double precision floating point number to specify an epoch). This can be used to achieve higher precision in timetag (this can have a significant impact when modeling Doppler observations from a deep space probe).\nIt is distributed as a single cross platform source making it easy to integrate in other projects whereas the SPICE toolkit is distributed one source per platform.But CALCEPH does not support all functions of the SPICE toolkit. If you need more functionalities SPICE.jl is a Julia wrapper for the SPICE toolkit."
},

{
    "location": "install/#",
    "page": "Retrieving and installing CALCEPH.jl",
    "title": "Retrieving and installing CALCEPH.jl",
    "category": "page",
    "text": ""
},

{
    "location": "install/#Retrieving-and-installing-CALCEPH.jl-1",
    "page": "Retrieving and installing CALCEPH.jl",
    "title": "Retrieving and installing CALCEPH.jl",
    "category": "section",
    "text": "In the Julia interpreter, run:Pkg.add(\"CALCEPH\")To start using it:using CALCEPH"
},

{
    "location": "introspection/#CALCEPH.timeScale",
    "page": "-",
    "title": "CALCEPH.timeScale",
    "category": "function",
    "text": "timeScale(eph)\n\nRetrieve the timescale associated with ephemeris handler eph    Returns 1 for TDB and 2 for TCB.\n\n\n\n\n\n"
},

{
    "location": "introspection/#CALCEPH.PositionRecord",
    "page": "-",
    "title": "CALCEPH.PositionRecord",
    "category": "type",
    "text": "PositionRecord\n\nstores position record metadata.\n\n\n\n\n\n"
},

{
    "location": "introspection/#CALCEPH.positionRecords",
    "page": "-",
    "title": "CALCEPH.positionRecords",
    "category": "function",
    "text": "positionRecords(eph)\n\nRetrieve position records metadata in ephemeris associated to    handler eph .\n\n\n\n\n\n"
},

{
    "location": "introspection/#CALCEPH.OrientationRecord",
    "page": "-",
    "title": "CALCEPH.OrientationRecord",
    "category": "type",
    "text": "OrientationRecord\n\nstores orientation record metadata.\n\n\n\n\n\n"
},

{
    "location": "introspection/#CALCEPH.orientationRecords",
    "page": "-",
    "title": "CALCEPH.orientationRecords",
    "category": "function",
    "text": "orientationRecords(eph)\n\nRetrieve orientation records metadata in ephemeris associated to    handler eph .\n\n\n\n\n\n"
},

{
    "location": "introspection/#CALCEPH.timespan",
    "page": "-",
    "title": "CALCEPH.timespan",
    "category": "function",
    "text": "timespan(eph::Ephem)\n\nThis function returns the first and last time available in the ephemeris file associated to eph.\n\nArguments:\n\neph : ephemeris\n\nReturn:\n\na tuple containing:     * firsttime: Julian date of the first time     * lasttime: Julian date of the last time     * continuous: information about the availability of the quantities over the time span\n\n    It returns the following value in the parameter continuous :\n\n    1 if the quantities of all bodies are available for any time between the first and last time.\n    2 if the quantities of some bodies are available on discontinuous time intervals between the first and last time.\n    3 if the quantities of each body are available on a continuous time interval between the first and last time,\n      but not available for any time between the first and last time.\n\nSee: https://www.imcce.fr/content/medias/recherche/equipes/asd/calceph/html/c/calceph.multiple.html#menu-calceph-gettimespan\n\n\n\n\n\n"
},

{
    "location": "introspection/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.timeScale\nCALCEPH.PositionRecord\nCALCEPH.positionRecords\nCALCEPH.OrientationRecord\nCALCEPH.orientationRecords\nCALCEPH.timespan"
},

{
    "location": "units/#CALCEPH.unitAU",
    "page": "-",
    "title": "CALCEPH.unitAU",
    "category": "constant",
    "text": "unitAU\n\nAstronomical unit: distance unit\n\n\n\n\n\n"
},

{
    "location": "units/#CALCEPH.unitKM",
    "page": "-",
    "title": "CALCEPH.unitKM",
    "category": "constant",
    "text": "unitKM\n\nkilometer: distance unit\n\n\n\n\n\n"
},

{
    "location": "units/#CALCEPH.unitDay",
    "page": "-",
    "title": "CALCEPH.unitDay",
    "category": "constant",
    "text": "unitDay\n\nday: time unit\n\n\n\n\n\n"
},

{
    "location": "units/#CALCEPH.unitSec",
    "page": "-",
    "title": "CALCEPH.unitSec",
    "category": "constant",
    "text": "unitSec\n\nsecond: time unit\n\n\n\n\n\n"
},

{
    "location": "units/#CALCEPH.unitRad",
    "page": "-",
    "title": "CALCEPH.unitRad",
    "category": "constant",
    "text": "unitRad\n\nradian: angle unit\n\n\n\n\n\n"
},

{
    "location": "units/#CALCEPH.useNaifId",
    "page": "-",
    "title": "CALCEPH.useNaifId",
    "category": "constant",
    "text": "useNaifId\n\nhas to be added to the unit argument when using NAIF integer codes for identification of center and target\n\n\n\n\n\n"
},

{
    "location": "units/#CALCEPH.outputEulerAngles",
    "page": "-",
    "title": "CALCEPH.outputEulerAngles",
    "category": "constant",
    "text": "outputEulerAngles\n\nhas to be added to the unit argument for orient to output Euler angles\n\n\n\n\n\n"
},

{
    "location": "units/#CALCEPH.outputNutationAngles",
    "page": "-",
    "title": "CALCEPH.outputNutationAngles",
    "category": "constant",
    "text": "outputNutationAngles\n\nhas to be added to the unit argument for orient to output nutation angles\n\n\n\n\n\n"
},

{
    "location": "units/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.unitAU\nCALCEPH.unitKM\nCALCEPH.unitDay\nCALCEPH.unitSec\nCALCEPH.unitRad\nCALCEPH.useNaifId\nCALCEPH.outputEulerAngles\nCALCEPH.outputNutationAngles"
},

{
    "location": "utilities/#CALCEPH.fivePointStencil",
    "page": "-",
    "title": "CALCEPH.fivePointStencil",
    "category": "function",
    "text": "fivePointStencil(f,x,n::Integer,h)\n\nEvaluates function f and its derivatives up to order n ∈ [0,4] at x: f(x)f(x)f^(n)(x) The result is an array of length n+1. Derivatives are numerically computed using the 5-point stencil method with h≠0 being the grid spacing: https://en.wikipedia.org/wiki/Five-point_stencil\n\n\n\n\n\n"
},

{
    "location": "utilities/#",
    "page": "-",
    "title": "-",
    "category": "page",
    "text": "CALCEPH.fivePointStencil"
},

]}
