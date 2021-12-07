import strutils
import tables

type 
    Coordinate* = ref object
        p1x: int
        p1y: int
        p2x: int
        p2y: int



proc parse_file*(fileContents: string) : seq[Coordinate] =
    var elems = newSeq[Coordinate]()

    for line in fileContents.splitLines():
        let p12 = line.split("->")
        let p1 = p12[0]
        let p2 = p12[1]

        let p1xy = p1.split(",")
        let p2xy = p2.split(",")

        let p1x = parseInt(p1xy[0].strip())
        let p1y = parseInt(p1xy[1].strip())
        let p2x = parseInt(p2xy[0].strip())
        let p2y = parseInt(p2xy[1].strip())

        elems.add(Coordinate(p1x: p1x, p1y: p1y, p2x: p2x, p2y: p2y))
    
    return elems


iterator count_dir(p1: int, p2: int) : int =
    if p1 <= p2:
        for i in countup(p1, p2):
            yield i
    else:
        for i in countdown(p1, p2):
            yield i


iterator count_dir_pairs(point: Coordinate) : tuple[x: int, y: int] =
    var xVals = newSeq[int]()
    var yVals = newSeq[int]()

    for x in count_dir(point.p1x, point.p2x):
        xVals.add(x)

    for y in count_dir(point.p1y, point.p2y):
        yVals.add(y)
    
    for i in 0..xVals.len() - 1:
        yield (x: xVals[i], y: yVals[i]) 



proc create_grid*(elems: seq[Coordinate], ignoreDir: bool = true) : Table[tuple[x: int, y:int], int] =
    var grid = initTable[tuple[x: int, y:int], int]()

    for elem in elems:
        if (not ignoreDir) and elem.p1x != elem.p2x and elem.p1y != elem.p2y:
            for point in count_dir_pairs(elem):
                if not grid.contains(point):
                    grid[point] = 0
                grid[point] += 1
        elif elem.p1x == elem.p2x:
            let ex = elem.p1x
            for ey in count_dir(elem.p1y, elem.p2y):
                let t = (x: ex, y: ey)
                if not grid.contains(t):
                    grid[t] = 0
                grid[t] += 1
        elif elem.p1y == elem.p2y:
            let ey = elem.p1y
            for ex in count_dir(elem.p1x, elem.p2x):
                let t = (x: ex, y: ey)
                if not grid.contains(t):
                    grid[t] = 0
                grid[t] += 1
    
    return grid
