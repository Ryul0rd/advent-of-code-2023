fn main() raises:
    var f = open('input.txt', 'r')
    let text = f.read()[:-1]
    f.close()
    let chunks = text.split('\n\n')
    var mappables = strvec_to_intvec(chunks[0].split(': ')[1].split(' '))

    for chunk_i in range(1, len(chunks)):
        let lines = chunks[chunk_i].split('\n')
        for mappable_i in range(len(mappables)):
            for line_i in range(1, len(lines)):
                let range_mapping = strvec_to_intvec(lines[line_i].split(' '))
                let to_range_start = range_mapping[0]
                let from_range_start = range_mapping[1]
                let range_size = range_mapping[2]

                var mapped = False
                if from_range_start <= mappables[mappable_i] < from_range_start + range_size:
                    let offset = mappables[mappable_i] - from_range_start
                    mappables[mappable_i] = to_range_start + offset
                    mapped = True
                if mapped:
                    break
                
    let lowest_mappable = vec_min(mappables)
    print(lowest_mappable)


fn strvec_to_intvec(strvec: DynamicVector[String]) raises -> DynamicVector[Int]:
    var intvec = DynamicVector[Int]()
    for i in range(len(strvec)):
        if len(strvec[i]) == 0:
            continue
        let number = atol(strvec[i])
        intvec.push_back(number)
    return intvec


fn vec_min(vec: DynamicVector[Int]) -> Int:
    # mojo doesn't seem to have a good way of getting a max int value
    var lowest = 2**31 - 1
    for i in range(len(vec)):
        if vec[i] < lowest:
            lowest = vec[i]
    return lowest


# only used for debugging
fn print_vec(vec: DynamicVector[Int]):
    print_no_newline('[')
    for i in range(len(vec)):
        if i != 0:
            print_no_newline(', ')
        print_no_newline(vec[i])
    print(']')
