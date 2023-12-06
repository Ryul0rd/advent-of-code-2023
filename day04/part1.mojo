from utils.vector import DynamicVector


fn main() raises:
    var f = open('input.txt', 'r')
    let text = f.read()[:-1]
    f.close()
    let lines = text.split('\n')

    var point_acc = 0
    for li in range(len(lines)):
        let header_and_body = lines[li].split(': ')
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
            point_acc += 2 ** (n_matches - 1)

    print(point_acc)


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
