using BinDeps

@BinDeps.setup

libcalceph = library_dependency("libcalceph")
provides(Sources,URI("https://www.imcce.fr/content/medias/recherche/equipes/asd/calceph/calceph-3.0.0.tar.gz"), libcalceph)

provides(BuildProcess,Autotools(configure_options =
    ["--enable-shared", "--disable-fortran", "--disable-python"],
    libtarget=joinpath("src", "libcalceph.la")),libcalceph, os = :Unix)

@BinDeps.install Dict(:libcalceph => :libcalceph)
