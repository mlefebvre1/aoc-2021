using FetchPuzzle

function solve_part1(puzzle)
    chunks = Iterators.Stateful(split(strip(puzzle), r"\r?\n\s*\r?\n"))
    numbers = map(x -> parse(Int, x), split(popfirst!(chunks), ','))
    boards = []
    for chunk in chunks
        board = permutedims(hcat([map(c -> parse(Int, c), split(line)) for line in split(chunk, "\n")]...))
        push!(boards, board)
    end


    checks = [falses(boards[1].size) for _ in boards]
    for number in numbers
        # find if number is in a board
        for (i, board) in enumerate(boards)
            idx = findfirst(==(number), board)
            if idx !== nothing
                checks[i][idx] = true
            end

            # check if any rows or cols are completed
            if any(all(checks[i], dims=1)) || any(all(checks[i], dims=2))
                # find the sum of all unmarked
                unmarked_idx = findall(==(false), checks[i])
                return (map(j -> board[j], unmarked_idx) |> sum) * number
            end
        end

    end


    # TODO: implement Day 4, Part 1.
end

function solve_part2(puzzle)
    chunks = Iterators.Stateful(split(strip(puzzle), r"\r?\n\s*\r?\n"))
    numbers = map(x -> parse(Int, x), split(popfirst!(chunks), ','))
    boards = []
    for chunk in chunks
        board = permutedims(hcat([map(c -> parse(Int, c), split(line)) for line in split(chunk, "\n")]...))
        push!(boards, board)
    end

    checks = [falses(boards[1].size) for _ in boards]
    for number in numbers
        # find if number is in a board
        board_to_delete = []
        for (i, board) in enumerate(boards)
            idx = findfirst(==(number), board)
            if idx !== nothing
                checks[i][idx] = true
            end

            # check if any rows or cols are completed
            if any(all(checks[i], dims=1)) || any(all(checks[i], dims=2))
                # find the sum of all unmarked
                unmarked_idx = findall(==(false), checks[i])

                if length(boards) == 1
                    return (map(j -> board[j], unmarked_idx) |> sum) * number
                else
                    push!(board_to_delete, i)
                end
            end
        end

        # delete boards that already win
        for i in sort(board_to_delete, rev=true)
            deleteat!(boards, i)
            deleteat!(checks, i)
        end
    end

end

puzzle = fetchPuzzle(4)
# puzzle = """7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
#
# 22 13 17 11  0
#  8  2 23  4 24
# 21  9 14 16  7
#  6 10  3 18  5
#  1 12 20 15 19
#
#  3 15  0  2 22
#  9 18 13 17  5
# 19  8  7 25 23
# 20 11 10 24  4
# 14 21 16 12  6
#
# 14 21 17 24  4
# 10 16 15  9 19
# 18  8 23 26 20
# 22 11 13  6  5
#  2  0 12  3  7
# """
println("part1 = ", solve_part1(puzzle))
println("part2 = ", solve_part2(puzzle))



