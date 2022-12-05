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
        item = intersect(📛...)[1]
        sum_priorities += priority(item)
        📛 = []
    end
end
@show sum_priorities
```

## Day 4. `subset`, `!isempty` and `intersect` again.

```julia
contained_part1 = 0
contained_part2 = 0
for l in eachline("./data/input_day4.txt")
    i, j, k, m = parse.(Int, split(l, r"[,-]"))
    🧝1, 🧝2 =  i:j, k:m
    if 🧝1 ⊆ 🧝2 || 🧝2 ⊆ 🧝1
        contained_part1 += 1
    end
    if !isempty(∩(🧝1,🧝2))
        contained_part2 += 1
    end
end
@show contained_part1
@show contained_part2
```

## Day 5. `popfirst!`, `pushfirst!`, `deleteat!`

```julia
lins = readlines("./data/input_day5.txt")

function getrules(sep, lins)
    rules = []
    for l in lins[sep+2:end]
        push!(rules, parse.(Int, split(l)[[2,4,6]]))
    end
    return rules
end

function getstop(lins)
    for (i,l) in enumerate(lins)
        if l != ""
            s = split(l, "")
            if s[2] == "1"
                lkeep = findall(x-> x != " ", s)
                return (i, lkeep)
            end
        end
    end
end

sep, pos = getstop(lins)

function getstacks(sep, pos)
    stacks =[]
    for p in pos
        stack = String[]
        for l in lins[1:sep-1]
            s = split(l, "")
            if s[p] != " "
                push!(stack, s[p])
            end
        end
        push!(stacks, stack)
    end
    stacks
end
# part 1
function move_📦!(stacks, rule)
    a, f, t = rule
    for _ in 1:a
        📦 = popfirst!(stacks[f])
        pushfirst!(stacks[t], 📦)
    end
end

stacks = getstacks(sep, pos)
rules = getrules(sep, lins)

for r in rules; move_📦!(stacks, r) end

@show join(first.(stacks));

# part 2

function move_📦!(stacks, rule)
    a, f, t = rule
    📦 = stacks[f][1:a]
    pushfirst!(stacks[t], 📦...)
    deleteat!(stacks[f], 1:a)
end

for r in rules; move_📦!(stacks, r) end

@show join(first.(stacks));
```