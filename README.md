<a id='ExcelDataStreams.ExcelDataStream-Tuple{AbstractString}' href='#ExcelDataStreams.ExcelDataStream-Tuple{AbstractString}'>#</a>
**`ExcelDataStreams.ExcelDataStream`** &mdash; *Method*.



ExcelDataStream( filename::AbstractString )

Constructor for type which gives access to an Excel file as a DataStream

**Arguments**

  * `filename::AbstractString` : the name of the Excel file to stream

**Keyword Arguments**

  * `columnindices::Vector{Int}` – The indices of columns to use as fields.  Defaults to empty.
  * `names::Vector{Symbol}` – The names to use for the fields.  Defaults to empty.
  * `eltypes::Vector{DataTypes}` – The types expected for each field.  Conversion will be attemped.  Defaults to empty.
  * `sheet::String` – Which sheet of the Excel file contains the data of interest.  Defaults to `sheet1`.
  * `skipstart::Int` – How many initial rows of the Excel file to skip.  Defaults to `0`.
  * `nastrings::Vector{String}` – Strings to consider to be missing data.  Defaults to empty.


<a target='_blank' href='https://github.com/atteson/ExcelDataStreams.jl/blob/4dd9db78e27b51c2dfd1806a0fcd5b41580e2c06/src/ExcelDataStreams.jl#L17-L34' class='documenter-source'>source</a><br>

