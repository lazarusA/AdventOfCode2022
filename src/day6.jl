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