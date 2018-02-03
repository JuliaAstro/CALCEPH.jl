

macro CalcephCheckStatus(stat,msg)
   return quote
      if ($(esc(stat)) == 0)
         throw(CalcephException($(esc(msg))))
      end
   end
end

macro CalcephCheckPointer(ptr,msg)
   return quote
      if ($(esc(ptr)) == C_NULL)
         throw(CalcephException($(esc(msg))))
      end
   end
end

macro CalcephCheckOrder(order)
   return quote
      local or = $(esc(order))
      if (or<0) || (or>3)
         throw(CalcephException("Order must be between 0 and 3."))
      end
   end
end

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
      @CalcephCheckPointer ptr "Unable to open ephemeris file(s)!"
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
    @CalcephCheckPointer eph.data "Ephemeris is not properly initialized!"
    stat = ccall((:calceph_prefetch, libcalceph), Int, (Ptr{Void},), eph.data)
    @CalcephCheckStatus stat "Unable to prefetch  ephemeris!"
    return
end
