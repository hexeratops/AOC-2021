import sequtils
import strutils
import sugar


type
    Gameboard* = ref object
        grid: seq[int]
        chosen: seq[bool]



proc newGameboards*(file: string) : seq[Gameboard] =
    # Bit of a dirty trick here, I add an extra newline to simplify the parsing.
    let fileData = readFile(file).splitLines()
    var 
        retVal = newSeq[Gameboard]()
        currentBoard = newSeq[int]()

    for i in 2..fileData.len() - 1:
        let line = fileData[i]
        
        let numbers = line.splitWhitespace().map(x => parseInt(x))

        if numbers.len() > 0:
            currentBoard.add(numbers)
        else:
            let newBoard = Gameboard(grid: currentBoard, chosen: currentBoard.map(x => false))
            retVal.add(newBoard)
            currentBoard = newSeq[int]()
    
    return retVal


proc callNumber*(board: Gameboard, value: int) =
    for i in 0..board.grid.len() - 1:
        if board.grid[i] == value:
            board.chosen[i] = true


proc checkRow(board: Gameboard, row: int): bool =
    let firstVal = row * 5
    for i in 0..4:
        if not board.chosen[firstVal + i]:
            return false

    return true


proc checkCol(board: Gameboard, col: int): bool =
    let firstVal = col
    for i in 0..4:
        if not board.chosen[firstVal + (i * 5)]:
            return false

    return true


proc validate*(board: Gameboard) : bool =
    for i in 0..4:
        if board.checkRow(i):
            return true
        if board.checkCol(i):
            return true
    
    #if board.checkDiagonal():
    #    return true
    return false


proc getScore*(board: Gameboard): int =
    var sum = 0
    for i in 0..board.grid.len() - 1:
        if not board.chosen[i]:
            sum += board.grid[i]
    return sum
