using FetchPuzzle

function solve_part1(puzzle)
    lines = filter(line -> line != "", split(puzzle, '\n'))

    pos = (0, 0)
    for line in lines
        h, d = pos
        dir, rawstep = split(line, ' ')
        step = parse(Int64, rawstep)
        if dir == "forward"
            pos = (h + step, d)
        elseif dir == "up"
            if d > step
                pos = (h, d-step)
            end
        elseif dir == "down"
            pos = (h, d+step)
        end
    end

    h, d = pos
    return h * d
end

function solve_part2(puzzle)
    lines = filter(line -> line != "", split(puzzle, '\n'))

    pos = (0, 0, 0)
    for line in lines
        h, d, a = pos
        dir, rawstep = split(line, ' ')
        step = parse(Int64, rawstep)
        if dir == "forward"
            pos = (h+step, d+step*a, a)
        elseif dir == "up"
            pos = (h, d, a-step)
        elseif dir == "down"
            pos = (h, d, a+step)
        end
    end
    h, d, _ = pos
    return h * d
end

puzzle = fetchPuzzle(2)
println(puzzle)
println("part1 = ", solve_part1(puzzle))
println("part2 = ", solve_part2(puzzle))
