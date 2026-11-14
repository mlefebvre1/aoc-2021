using FetchPuzzle

function solve_part1(puzzle)
    lines = filter(line -> line != "", split(puzzle, '\n'))
    bits = [parse.(Int, collect(line)) for line in lines]
    grid = permutedims(hcat(bits...))
    nb_rows, _ = grid.size
    nb_ones = sum(grid, dims=1)

    gamma = "0b"
    epsilon = "0b"
    for nb_one in nb_ones
        if nb_one * 2 > nb_rows
            gamma *= "0"
            epsilon *= "1"
        else
            gamma *= "1"
            epsilon *= "0"
        end
    end
    gammav = parse(Int, gamma)
    epsilonv = parse(Int, epsilon)
    return gammav * epsilonv
end

function solve_part2(puzzle)
    lines = filter(line -> line != "", split(puzzle, '\n'))
    bits = [parse.(Int, collect(line)) for line in lines]
    M = permutedims(hcat(bits...))
    oxygen = parse(Int, "0b" * join(rating(M, "oxygen")))
    scrubber = parse(Int, "0b" * join(rating(M, "scrubber")))
    return oxygen * scrubber
end

function rating(M, rating)
    greater = rating == "oxygen" ? 1 : 0
    lesser = rating == "oxygen" ? 0 : 1

    nb_rows, nb_bits = M.size
    for i in 1:nb_bits
        nb_ones = sum(M[:, i], dims=1)[1]
        if nb_ones*2 >= nb_rows # greater or equal
            M = M[M[:, i] .== greater, :]
        else # less
            M = M[M[:, i] .== lesser, :]
        end
        nb_rows, _ = M.size
        if nb_rows == 1
            return M
        end
    end
end

puzzle = fetchPuzzle(3)
println("part1 = ", solve_part1(puzzle))
println("part2 = ", solve_part2(puzzle))
