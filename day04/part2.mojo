from utils.vector import DynamicVector


fn main() raises:
    var f = open('input.txt', 'r')
    let text = f.read()[:-1]
    f.close()
    let lines = text.split('\n')

    var quantities = DynamicVector[Int]()
    for _ in range(len(lines)):
        quantities.push_back(1)
    for line_i in range(len(lines)):
        let header_and_body = lines[line_i].split(': ')
        let winning_and_hand = header_and_body[1].split(' | ')
        let winning_numbers_s = winning_and_hand[0].split(' ')
        let numbers_in_hand_s = winning_and_hand[1].split(' ')
        let winning_numbers = strvec_to_intvec(winning_numbers_s)
        let numbers_in_hand = strvec_to_intvec(numbers_in_hand_s)

        var n_matches = 0
        for i in range(len(numbers_in_hand)):
            if isin(numbers_in_hand[i], winning_numbers):
                n_matches += 1

        if n_matches > 0:
            for i in range(line_i + 1, line_i + n_matches + 1):
                quantities[i] += quantities[line_i]

    var total_tickets = 0
    for i in range(len(quantities)):
        total_tickets += quantities[i]

    print(total_tickets)


fn strvec_to_intvec(strvec: DynamicVector[String]) raises -> DynamicVector[Int]:
    var intvec = DynamicVector[Int]()
    for i in range(len(strvec)):
        if len(strvec[i]) == 0:
            continue
        let number = atol(strvec[i])
        intvec.push_back(number)
    return intvec


fn isin(a: Int, b: DynamicVector[Int]) -> Bool:
    for i in range(len(b)):
        if a == b[i]:
            return True
    return False


# only used for debugging
fn print_vec(vec: DynamicVector[Int]):
    print_no_newline('[')
    for i in range(len(vec)):
        if i != 0:
            print_no_newline(', ')
        print_no_newline(vec[i])
    print(']')
