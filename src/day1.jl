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