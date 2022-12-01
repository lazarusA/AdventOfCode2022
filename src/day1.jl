🧝🧝🧝 = []
🧝 = []
for 🌰 in eachline("./data/input_day1.txt")
    if 🌰 == ""
        push!(🧝🧝🧝, 🧝)
        🧝 = []
    else
        push!(🧝, parse(Int64, 🌰))
    end
end
maximum(sum.(🧝🧝🧝))
sum(sort(sum.(🧝🧝🧝), rev = true)[1:3])