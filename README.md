# AdventOfCode2022

## Day 1. A classic for loop and push

```julia
๐งs = []
๐ง = 0
for ๐ฐ in eachline("./data/input_day1.txt")
    if ๐ฐ == ""
        push!(๐งs, ๐ง)
        ๐ง = 0
    else
        ๐ง += parse(Int64, ๐ฐ)
    end
end
@show maximum(๐งs)
@show sum(sort(๐งs, rev = true)[1:3])
```

## Day 2. Overcomplicating things with multi dispatch

```julia
# Rules !
abstract type ๐ end
struct ๐ชจ <: ๐ end
struct โ <: ๐ end
struct ๐ <: ๐ end
# u win ๐
play(u::๐, o::๐ชจ) = 6 + 2
play(u::โ, o::๐) = 6 + 3
play(u::๐ชจ, o::โ) = 6 + 1
# u lose ๐ข
play(u::๐ชจ, o::๐) = 1
play(u::๐, o::โ) = 2
play(u::โ, o::๐ชจ) = 3
# draw ๐คฆ
play(u::๐, o::๐) = 3 + 2
play(u::โ, o::โ) = 3 + 3
play(u::๐ชจ, o::๐ชจ) = 3 + 1
# o -> oponent
A, B, C = ๐ชจ(), ๐(), โ()
# u -> you
X, Y, Z = ๐ชจ(), ๐(), โ()
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
        u = o == ๐() ? ๐ชจ() : o == โ() ? ๐() : โ()
        total_score += play(u, o)
    elseif s == "Y"
        total_score += play(o, o)
    elseif s == "Z"
        u = o == ๐ชจ() ? ๐() : o == ๐() ? โ() : ๐ชจ()
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
```

## Day 4. `subset`, `!isempty` and `intersect` again.

```julia
contained_part1 = 0
contained_part2 = 0
for l in eachline("./data/input_day4.txt")
    i, j, k, m = parse.(Int, split(l, r"[,-]"))
    ๐ง1, ๐ง2 =  i:j, k:m
    if ๐ง1 โ ๐ง2 || ๐ง2 โ ๐ง1
        contained_part1 += 1
    end
    if !isempty(โฉ(๐ง1,๐ง2))
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
#sep = findfirst(x -> x[2] == '1', lins)
#pos = findall(r"\d", lins[num_row]) |> x -> first.(x)
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
function move_๐ฆ!(stacks, rule)
    a, f, t = rule
    for _ in 1:a
        ๐ฆ = popfirst!(stacks[f])
        pushfirst!(stacks[t], ๐ฆ)
    end
end

stacks = getstacks(sep, pos)
rules = getrules(sep, lins)

for r in rules; move_๐ฆ!(stacks, r) end

@show join(first.(stacks));

# part 2
stacks = getstacks(sep, pos)
rules = getrules(sep, lins)

function move_๐ฆ!(stacks, rule)
    a, f, t = rule
    ๐ฆ = stacks[f][1:a]
    pushfirst!(stacks[t], ๐ฆ...)
    deleteat!(stacks[f], 1:a)
end

for r in rules; move_๐ฆ!(stacks, r) end

@show join(first.(stacks));
```

## Day 6. `unique`

```julia
ds_buffer = readline("./data/input_day6.txt")

function get_marker_pos(ds_buffer; n=4)
    for i in eachindex(ds_buffer)
        marker = []
        for j in 0:n-1
            push!(marker, ds_buffer[i+j])
        end
        if length(unique(marker))==n
            return i+n-1
        end
    end
end
# part 1
@show get_marker_pos(ds_buffer)
# part 2
@show get_marker_pos(ds_buffer; n = 14)
```
