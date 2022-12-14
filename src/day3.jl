# priority definition
function priority(c::Char)
    islowercase(c) ? 26 + c - 'z' : isuppercase(c) ? 52 + c -'Z' : error()
end
sum_priorities = 0
for l in eachline("./data/input_day3.txt")
    ๐ = collect(l)
    s = length(๐)
    ๐ฆ1, ๐ฆ2 = ๐[1:sรท2], ๐[sรท2+1:end]
    item = intersect(๐ฆ1, ๐ฆ2)[1]
    sum_priorities += priority(item)
end
@show sum_priorities
# part 2
sum_priorities = 0
๐ = []
for (i,l) in enumerate(eachline("./data/input_day3.txt"))
    ๐ = collect(l)
    push!(๐, ๐)
    if mod(i,3) == 0
        item = intersect(๐...)[1]
        sum_priorities += priority(item)
        ๐ = []
    end
end
@show sum_priorities

# https://twitter.com/rawlexander/status/1599003411080355840/photo/1
# priority = [indexin(line, ['a':'z'; 'A':'Z']) for line in eachline("./data/input_day3.txt")]
# Iterators.partition(priority, 3)
