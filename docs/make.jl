using Documenter, CALCEPH

makedocs(
    format = Documenter.HTML(
		prettyurls = get(ENV, "CI", nothing) == "true",
	),
	sitename = "CALCEPH.jl",
	authors = "Bernard Godard and the CALCEPH.jl contributors",
	pages = [
		"Tutorial" => "tutorial.md"
	],
)

deploydocs(
	repo = "github.com/JuliaAstro/CALCEPH.jl.git",
	target = "build",
)
