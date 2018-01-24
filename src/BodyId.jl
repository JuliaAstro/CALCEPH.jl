
mutable struct BodyId
   names :: Dict{Int,Set{Symbol}}
   id :: Dict{Symbol,Int}
   function BodyId()
       new(Dict{Int,Set{Symbol}}(),Dict{Symbol,Int}())
   end
end

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

# add(:jupiter,599)
# add(:ssb,0)
# add(:solar_system_barycenter,0)

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

const NaifId = BodyId()
loadData!(NaifId,joinpath(Pkg.dir("CALCEPH"), "data", "NaifIds.txt"))
