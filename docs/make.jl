using Documenter, CALCEPH

makedocs(modules=[CALCEPH],
        doctest=true,
        sitename = "CALCEPH.jl"
)

deploydocs(deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo = "github.com/bgodard/CALCEPH.jl.git")
