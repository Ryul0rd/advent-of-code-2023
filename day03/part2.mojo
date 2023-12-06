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

    var potential_gears = DynamicVector[PotentialGear]()
    for i in range(len(numbers)):
        let number = numbers[i]
        let start_row = max(0, number.row - 1)
        let end_row = min(len(lines), number.row + 2)
        let start_col = max(0, number.start - 1)
        let end_col = min(len(lines[0]), number.end + 1)

        for row in range(start_row, end_row):
            for col in range(start_col, end_col):
                let char = lines[row][col]
                if char == '*':
                    var new_gear = True
                    for gear_i in range(len(potential_gears)):
                        if potential_gears[gear_i].row == row and potential_gears[gear_i].col == col:
                            potential_gears[gear_i].value2 = number.value
                            new_gear = False
                    if new_gear:
                        potential_gears.push_back(PotentialGear(number.value, row, col))

    var accumulator = 0
    for i in range(len(potential_gears)):
        let potential_gear = potential_gears[i]
        if potential_gear.value2 != -1:
            accumulator += potential_gear.value1 * potential_gear.value2

    print(accumulator)


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


struct PotentialGear(CollectionElement):
    var value1: Int
    var value2: Int
    var row: Int
    var col: Int

    fn __init__(inout self, value: Int, row: Int, col: Int):
        self.value1 = value
        self.value2 = -1
        self.row = row
        self.col = col

    fn __copyinit__(inout self, existing: Self):
        self.value1 = existing.value1
        self.value2 = existing.value2
        self.row = existing.row
        self.col = existing.col

    fn __moveinit__(inout self, owned existing: Self):
        self.value1 = existing.value1
        self.value2 = existing.value2
        self.row = existing.row
        self.col = existing.col

    fn __del__(owned self):
        pass
