module FetchPuzzle

using HTTP

export fetchPuzzle

function fetchPuzzle(day)
    token = ENV["AOC_TOKEN_2021"]
    resp = HTTP.get(
        "https://adventofcode.com/2021/day/$day/input";
        headers=["Cookie" => token],
    )
    return String(resp.body)
end

end
