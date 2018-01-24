"
    CALCEPH

  This module is a wrapper of CALCEPH, IMCCE planetary ephemeris access
  library. It supports INPOPxx, JPL DExxx and SPICE ephemeris.

  https://www.imcce.fr/recherche/equipes/asd/calceph

"
module CALCEPH

deps = abspath(joinpath(splitdir(@__FILE__)[1], "..", "deps", "deps.jl"))
if isfile(deps)
    include(deps)
else
    error("libcalceph was not found. Please run 'Pkg.build(\"CALCEPH\").")
end

include("CalcephEphem.jl")
export CalcephEphem, CalcephPrefetch

include("CalcephCompute.jl")
export CalcephCompute,  CalcephComputeUnit, CalcephComputeOrder

include("BodyId.jl")
export NaifId

include("CalcephUnits.jl")
export CalcephUnitAU, CalcephUnitKM, CalcephUnitDay, CalcephUnitSec, CalcephUnitRad, CalcephUseNaifId

include("CalcephOrient.jl")
export CalcephOrientUnit, CalcephOrientOrder

include("CalcephConstants.jl")
export CalcephConstants

end # module
