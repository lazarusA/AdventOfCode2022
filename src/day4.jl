contained_part1 = 0
contained_part2 = 0
for l in eachline("./data/input_day4.txt")
    i, j, k, m = parse.(Int, split(l, r"[,-]"))
    🧝1, 🧝2 =  i:j, k:m
    if 🧝1 ⊆ 🧝2 || 🧝2 ⊆ 🧝1
        contained_part1 += 1
    end
    if !isempty(∩(🧝1,🧝2)) # try also \subsup, ⫓
        contained_part2 += 1
    end
end
@show contained_part1
@show contained_part2
