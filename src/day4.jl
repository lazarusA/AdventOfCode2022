contained_part1 = 0
contained_part2 = 0
for l in eachline("./data/input_day4.txt")
    uno, dos = split(l, ",")
    🧝1 =  collect(range(parse.(Int64, split(uno,"-"))...))
    🧝2 =  collect(range(parse.(Int64, split(dos,"-"))...))
    if 🧝1 ⊆ 🧝2 || 🧝2 ⊆ 🧝1
        contained_part1 += 1
    end
    if !isempty(∩(🧝1,🧝2))
        contained_part2 += 1
    end
end
@show contained_part1
@show contained_part2
