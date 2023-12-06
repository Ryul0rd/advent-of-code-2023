from utils.vector import DynamicVector
from utils.static_tuple import StaticTuple
from math import min, max


fn main() raises:
    var f = open('input.txt', 'r')
    let blueprint = f.read()
    f.close()

    var width = 0
    var height = 0
    for i in range(len(blueprint)):
        if blueprint[i] == '\n':
            height += 1
            if width == 0:
                width = i

    # find all numbers
    var numbers = DynamicVector[StaticTuple[5, Int]]()
    var number_start = 0
    var number_end = 0
    var in_number = False
    for i in range(len(blueprint)):
        let char = blueprint[i]
        if not in_number and is_digit(char):
            number_start = i
            in_number = True
        elif in_number and not is_digit(char):
            number_end = i
            in_number = False
            let start_col = number_start % (width + 1)
            let end_col = (number_end - 1) % (width + 1)
            let row = number_start // (width + 1)

            let value = atol(blueprint[number_start:number_end])
            let left = max(0, start_col - 1)
            let top = max(0, row - 1)
            let right = min(width - 1, end_col + 1)
            let bottom = min(height - 1, row + 1)
            let new_number = StaticTuple[5, Int](value, left, top, right, bottom)
            numbers.push_back(new_number)

    # find numbers with adjacent symbols
    var number_acc = 0
    for i in range(len(numbers)):
        let number = numbers[i]
        var has_adjacent_symbol = False
        if number[0] == 756:
            print(number[0], number[1], number[2], number[3], number[4])
        for y in range(number[2], number[4] + 1):
            for x in range(number[1], number[3] + 1):
                let space_to_check = (width + 1) * y + x
                let char_to_check = blueprint[space_to_check]
                if number[0] == 756:
                    print_no_newline(char_to_check)
                if char_to_check != '.' and not is_digit(char_to_check):
                    has_adjacent_symbol = True
            #print()
        if has_adjacent_symbol:
            number_acc += number[0]
        if number[0] == 756: 
            print(has_adjacent_symbol)

    print(number_acc)


fn symbol_at(text: String, x: Int, y: Int) -> String:
    let width = text.find('\n') + 1
    let index = width * y + x
    return text[index]


fn is_digit(char: String) -> Bool:
    let ascii_zero = 48
    let ascii_nine = 57
    return ascii_zero <= ord(char) <= ascii_nine
