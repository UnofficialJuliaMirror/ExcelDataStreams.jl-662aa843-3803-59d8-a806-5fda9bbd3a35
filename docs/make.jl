using Documenter, ExcelDataStreams

makedocs(
    format = :html,
    sitename = "ExcelDataStreams.jl",
    pages = ["Home" => "index.md"],
)

println( "\n\n*** ENVIRONMENT BEGIN ***\n\n" )
showall( ENV )
println( "\n\n*** ENVIRONMENT END ***\n\n" )

deploydocs(
    repo = "github.com/atteson/ExcelDataStreams.jl",
    target = "build",
    deps = nothing,
    make = nothing,
    julia = "0.6",
    osname = "linux",
)

