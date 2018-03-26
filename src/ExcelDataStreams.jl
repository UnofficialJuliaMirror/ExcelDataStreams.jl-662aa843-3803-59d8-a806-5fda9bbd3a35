module ExcelDataStreams

# package code goes here
using DataStreams
using Taro
using DataFrames
using DataArrays

export ExcelDataStream

initialized = false

type ExcelDataStream <: Data.Source
    data::DataFrame
end

"""
ExcelDataStream( filename::AbstractString )

Constructor for type which gives access to an Excel file as a DataStream

### Arguments

* `filename::AbstractString` : the name of the Excel file to stream

### Keyword Arguments
"""
function ExcelDataStream(
    filename::AbstractString,
    ;
    columnindices::Vector{Int} = Int[],
    names::Vector{Symbol} = String[],
    eltypes::Vector{DataType} = DataType[],
    sheet::String = "Sheet1",
    skipstart::Int = 0,
    nastrings::Vector{String} = String[],
)
    global initialized
    if !initialized
        Taro.init()
        initialized = true
    end
    excel = Workbook( filename )
    sheetdata = getSheet( excel, sheet )
    
    columns = [DataArray( eltype, 0 ) for eltype in eltypes]
    done = false
    rownum = skipstart
    while !done
        row = getRow( sheetdata, rownum )
        done = isnull(row)
        if !done
            for i = 1:length(names)
                cell = getCell( row, columnindices[i] )
                cellvalue = getCellValue( cell )
                if cellvalue == nothing || cellvalue in nastrings
                    push!( columns[i], missing )
                else
                    push!( columns[i], cellvalue )
                    done = false
                end
            end
            if done
                # the last row is all missing
                [pop!( column ) for column in columns]
            end
            rownum += 1
        end
    end

    df = DataFrame()
    for i = 1:length(names)
        df[names[i]] = columns[i]
    end
    return ExcelDataStream( df )
end

Data.schema( ed::ExcelDataStream ) =
    Data.Schema( eltypes(ed.data), string.(names(ed.data)), size(ed.data,1) )

Data.isdone( ed::ExcelDataStream, row::Int, col::Int ) = any((row,col).>size(ed.data))

Data.streamtype( ::Type{ExcelDataStream}, ::Type{Data.Field} ) = true

Data.streamfrom(ed::ExcelDataStream, ::Type{Data.Field}, ::Type{T}, row::Int, col::Int) where {T} =
    T(ed.data[row,col])

Data.accesspattern( ::ExcelDataStream ) = Data.RandomAccess

end # module
