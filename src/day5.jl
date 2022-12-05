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