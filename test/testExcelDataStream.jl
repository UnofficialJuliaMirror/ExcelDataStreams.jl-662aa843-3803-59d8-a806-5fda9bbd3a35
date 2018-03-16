using ExcelDataStreams
using DataStructures
using DataStreams
using DataFrames

url = "http://www.cboe.com/micro/buywrite/dailypricehistory.xls"

columnindices = OrderedDict{Symbol,Int}(
    :date => 1,
    :SPX => 4,
)
skipstartrows = 5

ed = ExcelDataStreams.ExcelDataStream(  url, columnindices, skipstartrows = skipstartrows )

df = Data.stream!( ed, DataFrame )
assert( all(size(df).>=(7984,2)) )
