import strutils
import tables
import algorithm

proc part_1(input: seq[string]) =
    var 
        counter = initCountTable[int]()
        inputLength = input.len() div 2
        gamma = 0
        epsilon = 0

    for line in input:
        for i in 0..line.len() - 1:
            if line[i] == '1':
                counter.inc(i)
    
    # Calculate gamma
    for i in 0..counter.len() - 1:
        gamma = gamma shl 1
        if counter[i] > inputLength:
            gamma = gamma or 1

    # Calculate epsilon
    for i in 0..counter.len() - 1:
        epsilon = epsilon shl 1
        if counter[i] < inputLength:
            epsilon = epsilon or 1

    echo gamma
    echo epsilon
    echo gamma * epsilon



proc iter_val(input: seq[string], idx: int, keepMax: bool) : int =
    var 
        counter = initCountTable[int]()
    
    for line in input:
        if line[idx] == '0':
            counter.inc(0)
        else:
            counter.inc(1)
    
    # Hoo boy, hack ahoy here.
    #
    # I have no idea why I need the >= for keepMin and >
    # for keepMax, but it makes the example problem work
    if keepMax:
        if counter[0] > counter[1]:
            return 0
        return 1
    else:
        if counter[1] >= counter[0]:
            return 0
        return 1



iterator filter_input(input: seq[string], idx: int, match: int) : string =
    for entry in input:
        let idxVal = parseInt($entry[idx])
        if idxVal == match:
            yield entry


proc part_2(input: seq[string]) =
    let 
        inputStrLen = input[0].len() - 1
        
    var 
        oxygenRating = 0
        co2Rating = 0
        elemList: seq[string]
    

    # Oxygen rating
    elemList = input                                        # Start by going through the entire list
    for i in 0..inputStrLen:
        var newList = newSeq[string]()

        let keep_val = iter_val(elemList, i, true)          # Find the digit to keep
        for elem in filter_input(elemList, i, keep_val):    # Iterate through the values to keep and add them to a new list
            newList.add(elem)
        
        if newList.len() == 1:
            oxygenRating = parseBinInt(newList[0])          # We found our value; capture it and return
            break

        elemList = newList                                  # Duplicate the new list into the search list

    #CO2 rating
    elemList = input
    for i in 0..inputStrLen:
        var newList = newSeq[string]()

        let keep_val = iter_val(elemList, i, false)
        for elem in filter_input(elemList, i, keep_val):
            newList.add(elem)
        
        if newList.len() == 1:
            co2Rating = parseBinInt(newList[0])
            break

        elemList = newList

    echo oxygenRating
    echo co2Rating
    echo oxygenRating * co2Rating




var input = readFile("input.txt").splitLines()

echo "Part 1"
part_1(input)

echo ""
echo "Part 2"
part_2(input)