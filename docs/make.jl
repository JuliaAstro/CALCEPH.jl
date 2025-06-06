using Documenter
using CALCEPH

makedocs(
    sitename = "CALCEPH.jl",
    authors = "Bernard Godard and the CALCEPH.jl contributors",
    pages = [
        "Home" => "index.md",
        "Tutorial" => "tutorial.md",
        "API" => "api.md"
    ],
    format = Documenter.HTML(;
         canonical = "https://JuliaAstro.org/CALCEPH/stable/",
    ),
)

deploydocs(
    repo = "github.com/JuliaAstro/CALCEPH.jl.git",
    versions = ["stable" => "v^", "v#.#"], # Restrict to minor releases
)
