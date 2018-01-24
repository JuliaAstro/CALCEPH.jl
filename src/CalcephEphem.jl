
"
    CalcephEphem

  Ephemeris descriptor. Create with:

    eph = CalCephEphem(filename)
    eph = CalCephEphem([filename1,filename2...])

  The ephemeris descriptor will be used to access the ephemeris and related
  data stored in the specified files.

  Because, Julia GC is lazy, you may want to free the memory managed by eph
  before you get rid of the reference to eph with:

    finalize(eph)

"
type CalcephEphem
   data :: Ptr{Void}
   function CalcephEphem(files::Vector{<:AbstractString})
      ptr = ccall((:calceph_open_array, libcalceph), Ptr{Void},
                  (Int, Ptr{Ptr{UInt8}}), length(files), files)
      if (ptr == C_NULL)
         error("Unable to open ephemeris file(s)!")
      end
      obj = new(ptr)
      finalizer(obj,CalcephEphemDestructor) # register object destructor
      return obj
   end
end

# to be called by gc when cleaning up
# not in the exposed interface but can be called with finalize(e)
function CalcephEphemDestructor(eph::CalcephEphem)
   if (eph.data == C_NULL)
      return
   end
   ccall((:calceph_close, libcalceph), Void, (Ptr{Void},), eph.data)
   eph.data = C_NULL
   return
end

CalcephEphem(file::AbstractString) = CalcephEphem([file])

"
    CalcephPrefetch(eph)

  This function prefetches to the main memory all files associated to the ephemeris descriptor eph.

"
function CalcephPrefetch(eph::CalcephEphem)
    CalcephCheck(eph)
    stat = ccall((:calceph_prefetch, libcalceph), Int, (Ptr{Void},), eph.data)
    if (stat == 0)
       error("Unable to prefetch ephemeris!")
    end
    return
end


"
    CalcephCheck(eph)

  Throws an exception if the ephemeris handler is a NULL pointer.

"
function CalcephIsValid(eph::CalcephEphem)
   if (eph.data == C_NULL)
      error("Ephemeris object is not propely initialized.")
   end
end
