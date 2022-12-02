# Rules ! Overcomplicating things with multi dispatch
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