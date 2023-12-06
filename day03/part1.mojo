from utils.vector import DynamicVector
from math import min, max


fn main() raises:
    var f = open('input.txt', 'r')
    let text = f.read()[:-1]
    f.close()
    let lines = text.split('\n')

    var numbers = DynamicVector[Number]()
    for row_i in range(len(lines)):
        let line = lines[row_i]
        var start = 0
        var end = 0
        var in_number = False
        for char_i in range(len(line)):
            let char = line[char_i]
            if not in_number and is_digit(char):
                in_number = True
                start = char_i
            elif in_number and not is_digit(char):
                in_number = False
                end = char_i
                let value = atol(line[start:end])
                numbers.push_back(Number(value, row_i, start, end))
        if in_number:
            in_number = False
            end = len(line)
            let value = atol(line[start:end])
            numbers.push_back(Number(value, row_i, start, end))

    var number_acc = 0
    for i in range(len(numbers)):
        let number = numbers[i]
        let start_row = max(0, number.row - 1)
        let end_row = min(len(lines), number.row + 2)
        let start_col = max(0, number.start - 1)
        let end_col = min(len(lines[0]), number.end + 1)

        var has_neighbor_symbol = False
        for row in range(start_row, end_row):
            for col in range(start_col, end_col):
                let char = lines[row][col]
                if char != '.' and not is_digit(char):
                    has_neighbor_symbol = True
        if has_neighbor_symbol:
            number_acc += number.value

    print(number_acc)



fn is_digit(char: String) -> Bool:
    let ascii_zero = 48
    let ascii_nine = 57
    return ascii_zero <= ord(char[0]) <= ascii_nine


struct Number(CollectionElement):
    var value: Int
    var row: Int
    var start: Int
    var end: Int

    fn __init__(inout self, value: Int, row: Int, start: Int, end: Int):
        self.value = value
        self.row = row
        self.start = start
        self.end = end

    fn __copyinit__(inout self, existing: Number):
        self.value = existing.value
        self.row = existing.row
        self.start = existing.start
        self.end = existing.end

    fn __moveinit__(inout self, owned existing: Number):
        self.value = existing.value
        self.row = existing.row
        self.start = existing.start
        self.end = existing.end

    fn __del__(owned self):
        pass
