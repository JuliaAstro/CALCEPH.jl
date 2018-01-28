"
    BodyId

  Body identifiers.
"
mutable struct BodyId
   "names from ID"
   names :: Dict{Int,Set{Symbol}}
   "ID from names"
   id :: Dict{Symbol,Int}
   function BodyId()
       new(Dict{Int,Set{Symbol}}(),Dict{Symbol,Int}())
   end
end

"
    add!(bid,name,id)

  Add a new mapping name->id into BodyId instance bid.

Example:

    bid=CALCEPH.BodyId()
    add!(bid,:tatooine,1)
    add!(bid,:dagobah,2)
    add!(bid,:Dagobah,2)

"
function add!(bid::BodyId,name::Symbol,id::Int)
   if (name ∈ keys(bid.id))
      if bid.id[name] != id
         error("Cannot map already defined identifier [$name] to a different ID [$id]")
      else
         return
      end
   end
   if id ∉ keys(bid.names)
      bid.names[id] = Set{Symbol}()
   end
   push!(bid.names[id],name)
   bid.id[name]=id
   nothing
end
"
    loadData!(bid,filename)

  Load mapping (body name,body ID) from file into BodyId instance bid.

  Example file [https://github.com/bgodard/CALCEPH.jl/blob/master/data/NaifIds.txt](https://github.com/bgodard/CALCEPH.jl/blob/master/data/NaifIds.txt)
"
function loadData!(bid::BodyId,filename::AbstractString)
   pattern1 = r"^\s*([-+]{0,1}\d+)\s+\'(.*)\'.*$"
   pattern2 = r"[\s-]"
   f = open(filename);
   cnt=0
   for ln0 in eachline(f)
      cnt += 1
      ln1=strip(ln0)
      if length(ln1)>0
         if ln1[1] != '#'
            m = match(pattern1,ln1)
            if isa(m,Void)
               error("parsing line $cnt in data input file: $filename:\n$ln0")
            end
            id = parse(Int,m.captures[1])
            name = Symbol(lowercase(replace(strip(m.captures[2]),pattern2,"_")))
            add!(bid,name,id)
         end
      end
   end
   close(f)
   nothing
end

"
    NaifId

NAIF identification numbers

Examples:
- NaifId.id[:sun]->10
- NaifId.id[:mars]->499
- NaifId.names[0]->Set(Symbol[:ssb, :solar_system_barycenter])

"
const NaifId = BodyId()
loadData!(NaifId,joinpath(Pkg.dir("CALCEPH"), "data", "NaifIds.txt"))

# NAIF IDs for Hyperbolic Asteroid 'Oumuamua (1I/2017 U1)
add!(NaifId,:oumuamua,3788040)

# NAIF IDs for CALCEPH time ephemeris
add!(NaifId,:timecenter,1000000000)
add!(NaifId,:ttmtdb    ,1000000001)
add!(NaifId,:tcgmtcb   ,1000000002)
