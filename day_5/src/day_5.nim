import coordinates
import tables

proc part_1(data: seq[Coordinate]) =
    let grid = data.create_grid()

    var count = 0
    for key in grid.keys():
        if grid[key] > 1:
            count += 1
    
    echo count


proc part_2(data: seq[Coordinate]) =
    let grid = data.create_grid(false)

    var count = 0
    for key in grid.keys():
        if grid[key] > 1:
            count += 1
    
    echo count

let contents = readFile("input.txt")
let data = parse_file(contents)

part_1(data)
part_2(data)