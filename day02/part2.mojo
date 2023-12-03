fn main() raises:
    var f = open('input.txt', 'r')
    let text = f.read()
    f.close()

    var power_acc = 0

    var red = 0
    var green = 0
    var blue = 0

    var in_number = False
    var value_start = 0
    var value_end = 0

    for i in range(text.__len__()):
        let char = text[i]
        if not in_number and is_digit(char):
            in_number = True
            value_start = i
        elif in_number and not is_digit(char):
            in_number = False
            value_end = i
        # d, g, and b are unique to reD, Green, and Blue, respectively and only appear once in their word
        elif char == 'd':
            red = max(red, atol(text[value_start:value_end]))
        elif char == 'g':
            green = max(green, atol(text[value_start:value_end]))
        elif char == 'b':
            blue = max(blue, atol(text[value_start:value_end]))
        elif char == '\n':
            let power = red * green * blue
            power_acc += power
            red = 0
            green = 0
            blue = 0

    print(power_acc)


fn max(a: Int, b: Int) -> Int:
    if a > b:
        return a
    else:
        return b


fn is_digit(char: String) -> Bool:
    let ascii_zero = 48
    let ascii_nine = 57
    return ascii_zero <= ord(char) <= ascii_nine
