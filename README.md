# AdventOfCode2022

## Day 1. A classic for loop and push

```julia
🧝s = []
🧝 = 0
for 🌰 in eachline("./data/input_day1.txt")
    if 🌰 == ""
        push!(🧝s, 🧝)
        🧝 = 0
    else
        🧝 += parse(Int64, 🌰)
    end
end
@show maximum(🧝s)
@show sum(sort(🧝s, rev = true)[1:3])
```

## Day 2. Overcomplicating things with multi dispatch

```julia
# Rules !
abstract type 📏 end
struct 🪨 <: 📏 end
struct ✂ <: 📏 end
struct 📃 <: 📏 end
# u win 😄
play(u::📃, o::🪨) = 6 + 2
play(u::✂, o::📃) = 6 + 3
play(u::🪨, o::✂) = 6 + 1
# u lose 😢
play(u::🪨, o::📃) = 1
play(u::📃, o::✂) = 2
play(u::✂, o::🪨) = 3
# draw 🤦
play(u::📃, o::📃) = 3 + 2
play(u::✂, o::✂) = 3 + 3
play(u::🪨, o::🪨) = 3 + 1
# o -> oponent
A, B, C = 🪨(), 📃(), ✂()
# u -> you
X, Y, Z = 🪨(), 📃(), ✂()
# count points
total_score = 0
for l in eachline("./data/input_day2.txt")
    o, u = Symbol.(split(l, " "))
    o, u = getfield(Main, o), getfield(Main, u)
    total_score += play(u, o)
end
@show total_score
# second part
total_score = 0
for l in eachline("./data/input_day2.txt")
    o, s = split(l, " ")
    o = getfield(Main, Symbol(o))
    if s == "X"
        u = o == 📃() ? 🪨() : o == ✂() ? 📃() : ✂()
        total_score += play(u, o)
    elseif s == "Y"
        total_score += play(o, o)
    elseif s == "Z"
        u = o == 🪨() ? 📃() : o == 📃() ? ✂() : 🪨()
        total_score += play(u, o)
    end
end
@show total_score
```

## Day 3. Characters with some `intersect` and `mod`.

```julia
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
        item = intersect(intersect(📛[1], 📛[2]), 📛[3])[1]
        sum_priorities += priority(item)
        📛 = []
    end
end
@show sum_priorities
```
