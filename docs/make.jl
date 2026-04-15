using TRACERSData
using Documenter

DocMeta.setdocmeta!(TRACERSData, :DocTestSetup, :(using TRACERSData); recursive = true)

makedocs(;
    modules = [TRACERSData],
    authors = "Beforerr <zzj956959688@gmail.com> and contributors",
    sitename = "TRACERSData.jl",
    format = Documenter.HTML(; size_threshold = nothing),
    pages = [
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo = "github.com/JuliaSpacePhysics/TRACERSData.jl",
    push_preview = true,
)
