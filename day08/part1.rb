input = File.read("input.txt")
input = input.split("\n").map{_1.split("|")[1].split}.flatten
input = input.map{
    case _1.size
    when 2
        1
    when 4
        4
    when 3
        7
    when 7
        8
    else
        0
    end
}

p input.size - input.count(0)