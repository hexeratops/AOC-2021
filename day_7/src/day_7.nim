import sequtils
import strutils
import sugar

proc part_1(crabs: seq[int]) : int =
    var min_cost = int.high()

    for i in crabs.min()..crabs.max():
        let new_cost = crabs.map(x => abs(i - x)).foldl(a + b)
        if new_cost < min_cost:
            min_cost = new_cost
    return min_cost


proc `⟮╯°□°⟯╯︵`(series: int) : int =
    return (int)((series * (series + 1)) / 2)


proc part_2(crabs: seq[int]) : int = 
    var min_cost = int.high()

    for i in crabs.min()..crabs.max():
        let new_cost = crabs.map(x => ⟮╯°□°⟯╯︵(abs(i - x))).foldl(a + b)
        if new_cost < min_cost:
            min_cost = new_cost
    return min_cost


var crabs = readFile("input.txt").split(",").map(x => parseInt(x))
echo part_1(crabs)
echo part_2(crabs)
