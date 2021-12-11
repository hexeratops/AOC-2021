import strutils
import tables
import deques
import algorithm

proc part_1(lines: seq[string]): int =
    var 
        score = 0
        openingChars = {'(': ')', '[': ']', '{': '}', '<': '>'}.toTable()
        scoreLookup = {')': 3, ']': 57, '}': 1197, '>': 25137}.toTable()
        charQueue = initDeque[char]()   

    for line in lines:
        charQueue.clear()

        for newChar in line:
            if newChar in openingChars:
                charQueue.addLast(newChar)
                continue

            let lastInput = charQueue.popLast()
            if openingChars[lastInput] != newChar:
                echo "Expected " & openingChars[lastInput] & ", but found " & newChar & " instead."
                score += scoreLookup[newChar]
                break
    
    return score



proc part_2(lines: seq[string]): int =
    var 
        scores = newSeq[int]()
        openingChars = {'(': ')', '[': ']', '{': '}', '<': '>'}.toTable()
        scoreLookup = {')': 1, ']': 2, '}': 3, '>': 4}.toTable()
        charQueue = initDeque[char]()   

    for line in lines:
        block newLineBlock:
            charQueue.clear()
            
            # Check for syntactical correctness
            for newChar in line:
                if newChar in openingChars:
                    # Build up a queue of opening chars
                    charQueue.addLast(newChar) 
                    continue

                # Check that the current char terminates the most recent opening char
                let lastInput = charQueue.popLast()
                if openingChars[lastInput] != newChar:
                    echo "Expected " & openingChars[lastInput] & ", but found " & newChar & " instead."
                    # Get out of here! Go to the next line.
                    break newLineBlock
            
            
            # If we get to this point, the char queue is incomplete 
            # rather than broken. So, lets fix it!
            var 
                lineTotal = 0
                fixedEnding = ""

            while charQueue.len() > 0:
                # Easy peasy!
                let newChar = charQueue.popLast()
                let fixedChar = openingChars[newChar]

                lineTotal = (lineTotal * 5) + scoreLookup[fixedChar]
                fixedEnding &= fixedChar
            
            if lineTotal > 0:
                scores.add(lineTotal)
                echo "Fixed end: " & $fixedEnding & " | score: " & $lineTotal
    
    let idx = scores.len() div 2
    scores.sort()

    return scores[idx]



var lines = readFile("input.txt").splitLines()
echo part_1(lines)
echo part_2(lines)