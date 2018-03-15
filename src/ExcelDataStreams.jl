module ExcelDataStreams

# package code goes here
using HTTP
using DataStreams
using ExcelReaders
using DataFrames
using DataStructures

type ExcelDataStream <: Data.Source
    data::DataFrame
end

function ExcelDataStream(
    url::AbstractString,
    columnindices::OrderedDict{Symbol,Int},
    ;
    sheet::String = "Sheet1",
    skipstartrows::Int = 0,
)
    rawdata = HTTP.request( "GET", url );
    
    filename = tempname()
    open( filename, "w") do file
        write( file, rawdata.body )
    end
    
    excel = openxl( filename )
    sheetdata = readxlsheet( excel, sheet, skipstartrows=skipstartrows );
    
    df = DataFrame()
    for (name,index) in columnindices
        col = sheetdata[:,index]
        lastrow = findfirst( isna.(col) )-1
        col = col[1:lastrow]
        if size(df,1) > lastrow
            col = [col; fill(NA,size(df,1) - lastrow)]
        elseif size(df, 1) < lastrow
            for i = 1:lastrow-size(df,1)
                push!( df, fill(NA,size(df,2)) )
            end
        end
        types = setdiff(unique(typeof.(col)),[NAtype])
        length(types) != 1 && error( "Couldn't work out type of column $name" )
        df[name] = DataVector{types[1]}(col)
    end
    return ExcelDataStream( df )
end

Data.isdone( ed::ExcelDataStream, row::Int, col::Int ) = any((row,col).>size(ed.data))

Data.schema( ed::ExcelDataStream, ::Type{Data.Field} ) =
    Data.Schema( string.(names(ed.data)), Vector{DataType}(eltypes(ed.data)), size(ed.data,1) )

Data.streamtype( ::Type{ExcelDataStream}, ::Type{Data.Field} ) = true

Data.streamfrom(ed::ExcelDataStream, ::Type{Data.Field}, ::Type{Nullable{T}}, row::Int, col::Int) where {T} =
    isna(ed.data[row,col]) ? Nullable{T}() : Nullable{T}(T(ed.data[row,col]))

Data.streamfrom(ed::ExcelDataStream, ::Type{Data.Field}, ::Type{T}, row::Int, col::Int) where {T} =
    T(ed.data[row,col])

end # module
