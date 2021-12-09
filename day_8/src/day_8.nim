import sequtils
import strutils
import sugar
import algorithm

proc part_1(lines: seq[seq[string]]) : int =
    let uniqueLenCounts = {
        2, 4, 3, 7
    }

    var total = 0

    for signals in lines.map(x => x[1].split(" ")):
        for signal in signals:
            if uniqueLenCounts.contains(signal.len()):
                total += 1
        
    return total


proc part_2(lines: seq[seq[string]]) : int = 
    var retVal = 0

    for line in lines:
        let signals = line[0].split(" ")
        let output = line[1].split(" ")

        # Find the things we know
        var d1 = signals.filter(x => x.len() == 2)[0]
        var d4 = signals.filter(x => x.len() == 4)[0]
        var d7 = signals.filter(x => x.len() == 3)[0]
        var d8 = signals.filter(x => x.len() == 7)[0]

        # Initialize the entire sequence
        var entireSequence = 0

        for signal in output:
            # Create a place for the current digit
            var currDigit = 0 

            # Count the number of places we match our known values
            let d1Matches = signal.countIt(d1.contains(it))
            let d4Matches = signal.countIt(d4.contains(it))
            let d7Matches = signal.countIt(d7.contains(it))
            let d8Matches = signal.countIt(d8.contains(it))
            
            # Check the segment matches. If we have a static length,
            # its relatively easy to find the segment. If its not though,
            # we do a pattern match against the known segments to deduce
            # which it is.

            if signal.len() == 2:
                currDigit = 1
            elif d8Matches == 5 and d1Matches == 1 and d4Matches == 2 and d7Matches == 2:
                currDigit = 2 
            elif d8Matches == 5 and d1Matches == 2 and d4Matches == 3 and d7Matches == 3:
                currDigit = 3
            elif signal.len() == 4:
                currDigit = 4
            elif d8Matches == 5 and d1Matches == 1 and d4Matches == 3 and d7Matches == 2:
                currDigit = 5
            elif d8Matches == 6 and d1Matches == 1 and d4Matches == 3 and d7Matches == 2:
                currDigit = 6
            elif signal.len() == 3:
                currDigit = 7
            elif signal.len() == 7:
                currDigit = 8
            elif d8Matches == 6 and d1Matches == 2 and d4Matches == 4 and d7Matches == 3:
                currDigit = 9
            elif d8Matches == 6 and d1Matches == 2 and d4Matches == 3 and d7Matches == 3:
                currDigit = 0
            else:
                # Should never happen
                raise newException(ValueError, "Oh no... You broke it, pal.")
            
            entireSequence = (entireSequence * 10) + currDigit
        
        # Because the problem demands it, add the sequence
        retVal += entireSequence
            
             

    return retVal


var lines = readFile("input.txt").splitLines().map(x => x.split("|").map(x => x.strip()))

echo part_1(lines)
echo part_2(lines)