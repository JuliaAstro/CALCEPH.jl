using Documenter, CALCEPH

makedocs(
        modules = [CALCEPH],
        format = :html,
	sitename = "CALCEPH.jl",
	authors = "Bernard Godard and the CALCEPH.jl contributors",
	pages = Any[
		"Tutorial"   => "index.md"
	],
)

deploydocs(
	repo = "github.com/JuliaAstro/CALCEPH.jl.git",
	target = "build",
)
