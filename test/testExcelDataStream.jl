using ExcelDataStreams
using DataStructures
using DataStreams
using DataFrames

url = "http://www.cboe.com/micro/buywrite/dailypricehistory.xls"

columnindices = [0,3]
names = [:date, :SPX]
eltypes = [Date, Float64]
sheet = "Sheet1"
skipstart = 5
nastrings = ["N/A"]

ed = ExcelDataStreams.ExcelDataStream(
    url,
    columnindices = columnindices,
    names = names,
    eltypes = eltypes,
    sheet = sheet,
    skipstart = skipstart,
    nastrings = nastrings,
)

df = Data.close!( Data.stream!( ed, DataFrame ) )
assert( size(df,1)>=7984 )
assert( size(df,2)==2 )
