fn main() raises:
    var f = open('input.txt', 'r')
    let text = f.read()
    f.close()

    let ascii_newline = 10
    let ascii_zero = 48
    let ascii_nine = 57

    var ones_place_acc = 0
    var tens_place_acc = 0
    var first_digit_seen = False
    var last_digit_seen = 0

    for i in range(text.__len__()):
        let char = ord(text[i])
        var digit = -1
        if ascii_zero <= char <= ascii_nine:
            digit = char - ascii_zero
        elif char == ascii_newline:
            ones_place_acc += last_digit_seen
            first_digit_seen = False
        elif text[i:i+3] == 'one':
            digit = 1
        elif text[i:i+3] == 'two':
            digit = 2
        elif text[i:i+5] == 'three':
            digit = 3
        elif text[i:i+4] == 'four':
            digit = 4
        elif text[i:i+4] == 'five':
            digit = 5
        elif text[i:i+3] == 'six':
            digit = 6
        elif text[i:i+5] == 'seven':
            digit = 7
        elif text[i:i+5] == 'eight':
            digit = 8
        elif text[i:i+4] == 'nine':
            digit = 9

        if digit != -1:
            last_digit_seen = digit
            if not first_digit_seen:
                tens_place_acc += digit
                first_digit_seen = True

    let answer = tens_place_acc * 10 + ones_place_acc
    print(answer)
