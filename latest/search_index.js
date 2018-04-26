var documenterSearchIndex = {"docs": [

{
    "location": "index.html#ExcelDataStreams.ExcelDataStream-Tuple{AbstractString}",
    "page": "Home",
    "title": "ExcelDataStreams.ExcelDataStream",
    "category": "method",
    "text": "ExcelDataStream( filename::AbstractString; kwargs... )\n\nConstructor for type which gives access to an Excel file as a DataStream\n\nArguments\n\nfilename::AbstractString : the name of the Excel file to stream\n\nKeyword Arguments\n\ncolumnindices::Vector{Int} – The indices of columns to use as fields.  Defaults to empty.\nnames::Vector{Symbol} – The names to use for the fields.  Defaults to empty.\neltypes::Vector{DataTypes} – The types expected for each field.  Conversion will be attemped.  Defaults to empty.\nsheet::String – Which sheet of the Excel file contains the data of interest.  Defaults to sheet1.\nskipstart::Int – How many initial rows of the Excel file to skip.  Defaults to 0.\nnastrings::Vector{String} – Strings to consider to be missing data.  Defaults to empty.\n\n\n\n"
},

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": "ExcelDataStream( filename::AbstractString )"
},

]}
