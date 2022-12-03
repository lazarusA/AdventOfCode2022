# priority definition
function priority(c::Char)
    islowercase(c) ? 26 + c - 'z' : isuppercase(c) ? 52 + c -'Z' : error()
end
sum_priorities = 0
for l in eachline("./data/input_day3.txt")
    🎒 = collect(l)
    s = length(🎒)
    📦1, 📦2 = 🎒[1:s÷2], 🎒[s÷2+1:end]
    item = intersect(📦1, 📦2)[1]
    sum_priorities += priority(item)
end
@show sum_priorities
# part 2
sum_priorities = 0
📛 = []
for (i,l) in enumerate(eachline("./data/input_day3.txt"))
    🎒 = collect(l)
    push!(📛, 🎒)
    if mod(i,3) == 0
        item = intersect(📛...)[1]
        sum_priorities += priority(item)
        📛 = []
    end
end
@show sum_priorities