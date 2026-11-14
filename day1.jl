using FetchPuzzle

function solve_part1(puzzle)
    lines = filter(line -> line != "", split(puzzle, '\n'))


    nb_increasing = 0
    prev = typemax(UInt64)
    for i in 1:length(lines)
        y = parse(UInt64, lines[i])
        if y > prev
            nb_increasing += 1
        end
        prev = y
    end
    return nb_increasing
end


function solve_part2(puzzle)
    lines = filter(line -> line != "", split(puzzle, '\n'))

    nb_increasing = 0
    prev_sum = typemax(UInt64)
    for iend in 3:length(lines)
        win_sum = map(x -> parse(UInt64, x), lines[(iend-2):iend]) |> sum
        if win_sum > prev_sum
            nb_increasing += 1
        end
        prev_sum = win_sum
    end
    return nb_increasing
end


puzzle = fetchPuzzle(1)
println("part1 = ", solve_part1(puzzle))
println("part2 = ", solve_part2(puzzle))

