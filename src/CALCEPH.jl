module CALCEPH

deps = abspath(joinpath(splitdir(@__FILE__)[1], "..", "deps", "deps.jl"))
if isfile(deps)
    include(deps)
else
    error("libcalceph was not found. Please run 'Pkg.build(\"CALCEPH\").")
end

type CalcephEphem
   data :: Ptr{Void}
   function CalcephEphem(files::Vector{T} where T<:AbstractString)
      ptr = ccall((:calceph_open_array, libcalceph), Ptr{Void}, (Int, Ptr{Ptr{UInt8}}), length(files), files)
      if (ptr == C_NULL)
         error("Unable to open ephemeris file(s)!")
      else
         res = new(ptr)
         finalizer(res,_cleanup)
         res
      end
   end
end

function _cleanup(e::CalcephEphem)
   ccall((:calceph_close, libcalceph), Void, (Ptr{Void},), e.data) 
   e.data = C_NULL    
end

CalcephEphem(file::AbstractString) = CalcephEphem([file])

export CalcephEphem

end # module
