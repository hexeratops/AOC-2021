import os
import sequtils
import sugar
import strutils
 
proc part1(filename: string) : int =
    var prevVal: int = 0
    var counter: int = 0

    for line in lines(filename):
        let iVal = parseInt(line)
        if prevVal != 0 and prevVal < iVal:
            counter = counter + 1
        prevVal = iVal

    return counter


proc part2(filename: string) : int =
    let contents = readFile(filename).splitLines().map(x => parseInt(x))
    var prevVal = 0
    var counter = 0

    for i in 0..contents.len():
        if i + 2 >= contents.len():
            break

        var cSum = 0
        for j in i..(i + 2):
            cSum += contents[j]

        echo cSum
        if cSum > prevVal and prevVal != 0:
            counter = counter + 1
        
        prevVal = cSum
    
    return counter


when isMainModule:
    let filename = os.paramStr(1)
    echo part2(filename)