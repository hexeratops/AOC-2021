import strutils
import sequtils
import sugar
import sets
import algorithm

type 
    Coordinate = tuple
        x: int
        y: int


iterator neighbours(arr: seq[seq[int]], xOffset: int, yOffset: int) : int =
    let yDim = arr.len() - 1
    let xDim = arr[0].len() - 1

    for y in max(0, yOffset - 1)..min(yDim, yOffset + 1):
        for x in max(0, xOffset - 1)..min(xDim, xOffset + 1):
            if x != xOffset or y != yOffset:
                yield arr[y][x]


proc basin(arr: seq[seq[int]], initialXOffset: int, initialYOffset: int) : int =
    let 
        yDim = arr.len() - 1
        xDim = arr[0].len() - 1

    var 
        basinCoordinates = initHashSet[Coordinate]()
        checkedCoordinates = initHashSet[Coordinate]()
        basinSize = 0

    basinCoordinates.incl((x: initialXOffset, y: initialYOffset))
    checkedCoordinates.incl((x: initialXOffset, y: initialYOffset))

    while basinCoordinates.len() > 0:
        let 
            basin = basinCoordinates.pop()
            yMin = max(0, basin.y - 1)
            yMax = min(yDim, basin.y + 1)
            xMin = max(0, basin.x - 1)
            xMax = min(xDim, basin.x + 1)

        # So the algorithm itself is fairly simple in theory.
        # We do a "+" search around the coordinate. If we find anything
        # around it under 9, we add the coordinate to our basin queue.
        for y in yMin..yMax:
            if y == basin.y:
                continue

            let
                coord = (x: basin.x, y: y)
                currentHeight = arr[y][basin.x]

            if currentHeight != 9 and not checkedCoordinates.contains(coord):
                basinCoordinates.incl(coord)
        
        for x in xMin..xMax:
            if x == basin.x:
                continue

            let
                coord = (x: x, y: basin.y)
                currentHeight = arr[basin.y][x]

            if currentHeight != 9 and not checkedCoordinates.contains(coord):
                basinCoordinates.incl(coord)
        
        # We're also keeping track of the checked basins so we don't double
        # count by mistake.
        checkedCoordinates.incl(basin)
        basinSize += 1
    
    return basinSize
                
    



proc part_1(arr: seq[seq[int]]) : int =
    var runningSum = 0

    for y in 0..arr.len() - 1:
        for x in 0..arr[y].len() - 1:
            let instVal = arr[y][x]
            var isMatch = true

            for neighbour in neighbours(arr, x, y):
                isMatch = isMatch and (neighbour >= instVal)
            
            if isMatch:
                runningSum += (instVal + 1)
    
    return runningSum



proc part_2(arr: seq[seq[int]]) : int =
    var allSizes = newSeq[int]()

    for y in 0..arr.len() - 1:
        for x in 0..arr[y].len() - 1:
            let instVal = arr[y][x]
            var isMatch = true

            for neighbour in neighbours(arr, x, y):
                isMatch = isMatch and (neighbour >= instVal)
            
            if isMatch:
                allSizes.add(basin(arr, x, y))

    
    allSizes.sort(SortOrder.Descending)
    return allSizes[0] * allSizes[1] * allSizes[2]




var lines = readFile("input.txt").splitLines().map(x => x.map(y => ((int)y) - 0x30))
echo part_1(lines)
echo part_2(lines)