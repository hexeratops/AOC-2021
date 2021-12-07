import sequtils
import strutils
import deques
import sugar
import bigints


# Dumb brute force way. Don't go above 100-200 or you'll run out of ram.
proc part_1(fish: seq[int], cycles: int) : int =
    var fish = fish.deepCopy()
    var pending_additions = 0

    for fish_cycle in 1..cycles:
        for i in 0..pending_additions - 1:
            fish.add(9) #Because it's about to go down to 8
        pending_additions = 0

        for fish_idx in countdown(fish.len() - 1, 0):
            fish[fish_idx] -= 1
            if fish[fish_idx] == 0:
                pending_additions += 1
        
        #echo repr fish

        for fish_idx in countdown(fish.len() - 1, 0):
            if fish[fish_idx] == 0:
                fish[fish_idx] = 7 #Because its about to go down to 6

    return fish.len()


# Smarter way. Also uses bigint, so it can go on
# for literally hours if you want it to.
proc part_2(fish: seq[int], cycles: int) : BigInt =
    var fish = fish.deepCopy()

    var fish_queue: Deque[BigInt] = newSeq[BigInt](9).toDeque()
    for fish_idx in fish:
        fish_queue[fish_idx] += 1
    
    for fish_cycle in 1..cycles:
        let new_fish = fish_queue[0]
        fish_queue[7] += new_fish
        
        if fish_cycle == cycles:
            return fish_queue.foldl(a + b)

        fish_queue.popFirst()
        fish_queue.addLast(new_fish)

var fish = readFile("input.txt").split(",").map(x => parseInt(x))
#echo part_1(fish, 80)
echo part_2(fish, 80)       # Just use part 2 for part 1, it's the better solution anyway
echo part_2(fish, 256)