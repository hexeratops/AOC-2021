import gameboard

import strutils
import sequtils 
import sugar


proc part_1(boards: seq[Gameboard], numbers: seq[int]) =
    var boards = boards.deepCopy()
    
    for i in numbers:
        for board in boards:
            board.callNumber(i)

        for board in boards:
            if board.validate():
                echo board.getScore() * i
                return



proc part_2(boards: seq[Gameboard], numbers: seq[int]) =
    var boards = boards.deepCopy()

    for i in numbers:
        for j in countdown(boards.len() - 1, 0):
            boards[j].callNumber(i)

            if boards[j].validate():
                if boards.len() > 1:
                    boards.del(j)
                else:
                    echo boards[j].getScore() * i
                    return




var boards = newGameboards("input.txt")
let numbers = readFile("input.txt").splitLines()[0].split(",").map(x => parseInt(x))

part_1(boards, numbers)
part_2(boards, numbers)