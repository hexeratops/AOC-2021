import strutils

proc part_1() =
    var
        horizontal = 0
        depth = 0

    for line in lines("input.txt"):
        let 
            components = line.split(' ')
            dir = components[0]
            magnitude = parseInt(components[1])

        if dir == "forward":
            horizontal += magnitude
        elif dir == "down":
            depth += magnitude
        elif dir == "up":
            depth -= magnitude
    
    echo $horizontal & " " & $depth
    echo horizontal * depth



proc part_2() =
    var
        horizontal = 0
        depth = 0
        aim = 0

    for line in lines("input.txt"):
        let 
            components = line.split(' ')
            dir = components[0]
            magnitude = parseInt(components[1])

        if dir == "forward":
            horizontal += magnitude
            depth += aim * magnitude
        elif dir == "down":
            aim += magnitude
        elif dir == "up":
            aim -= magnitude
    
    echo $horizontal & " " & $depth
    echo horizontal * depth



when isMainModule:
    part_2()
