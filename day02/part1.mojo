fn main() raises:
    var f = open('input.txt', 'r')
    let text = f.read()
    f.close()

    let max_red = 12
    let max_green = 13
    let max_blue = 14

    var id_acc = 0

    var game_id = 0
    var game_possible_so_far = True
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
        if char == ':':
            game_id = atol(text[value_start:value_end])
        # d, g, and b are unique to reD, Green, and Blue, respectively and only appear once in their word
        elif char == 'd':
            let red = atol(text[value_start:value_end])
            if red > max_red:
                game_possible_so_far = False
        elif char == 'g':
            let green = atol(text[value_start:value_end])
            if green > max_green:
                game_possible_so_far = False
        elif char == 'b':
            let blue = atol(text[value_start:value_end])
            if blue > max_blue:
                game_possible_so_far = False
        elif char == '\n':
            if game_possible_so_far:
                id_acc += game_id
            game_possible_so_far = True

    print(id_acc)


fn is_digit(char: String) -> Bool:
    let ascii_zero = 48
    let ascii_nine = 57
    return ascii_zero <= ord(char) <= ascii_nine
