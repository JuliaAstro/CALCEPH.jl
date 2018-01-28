using Documenter, CALCEPH

makedocs(modules=[CALCEPH],
        doctest=true)

deploydocs(deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo = "github.com/bgodard/CALCEPH.git",
    julia  = "0.6",
    osname = "linux")
