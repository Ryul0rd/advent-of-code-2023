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
        if ascii_zero <= char <= ascii_nine:
            let digit = char - ascii_zero
            last_digit_seen = digit
            if not first_digit_seen:
                tens_place_acc += digit
                first_digit_seen = True
        elif char == ascii_newline:
            ones_place_acc += last_digit_seen
            first_digit_seen = False

    let answer = tens_place_acc * 10 + ones_place_acc
    print(answer)
