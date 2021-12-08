require 'pp'

inputs = File.read("input.txt")
inputs = inputs.split("\n").map{_1.split("|").map(&:split)}
outputs = []
inputs.each do |input, output|
    input = input.map(&:chars)
    output = output.map(&:chars)

    input_mapping = []
    input_mapping[1] = input.find{_1.size==2}.sort
    input_mapping[4] = input.find{_1.size==4}.sort
    input_mapping[7] = input.find{_1.size==3}.sort
    input_mapping[8] = input.find{_1.size==7}.sort

    segment_mapping = { a: nil, b: nil, c: nil, d: nil, e: nil, f: nil, g: nil}
    segment_mapping[:a] = (input_mapping[7] -  input_mapping[1])[0]
    segment_mapping[:g] = input.map{|i| (i - [segment_mapping[:a]] - input_mapping[4]) }.find{_1.size==1}[0]
    segment_mapping[:e] = input.map{|i| (i - [segment_mapping[:a], segment_mapping[:g]] - input_mapping[4]) }.find{_1.size==1}[0]
    segment_mapping[:d] = input.map{|i| (i - [segment_mapping[:a], segment_mapping[:g]] - input_mapping[1]) }.find{_1.size==1}[0]
    segment_mapping[:b] = input.map{|i| (i - [segment_mapping[:g], segment_mapping[:e], segment_mapping[:d]] - input_mapping[7]) }.find{_1.size==1}[0]
    segment_mapping[:f] = input.flatten.tally.find{_2==9}[0]
    segment_mapping[:c] = (%w{a b c d e f g} - segment_mapping.values)[0]


    input_mapping[0] = input.find{|i|
        (i - [segment_mapping[:a],
            segment_mapping[:b],
            segment_mapping[:c],
            segment_mapping[:e],
            segment_mapping[:f],
            segment_mapping[:g]]).size == 0 && i.size == 6
    }.sort

    input_mapping[2] = input.find{|i|
        (i - [segment_mapping[:a],
            segment_mapping[:d],
            segment_mapping[:c],
            segment_mapping[:e],
            segment_mapping[:g]]).size == 0 && i.size == 5
    }.sort

    input_mapping[3] = input.find{|i|
        (i - [segment_mapping[:a],
            segment_mapping[:c],
            segment_mapping[:d],
            segment_mapping[:f],
            segment_mapping[:g]]).size == 0 && i.size == 5
    }.sort

    input_mapping[5] = input.find{|i|
        (i - [segment_mapping[:a],
            segment_mapping[:b],
            segment_mapping[:d],
            segment_mapping[:f],
            segment_mapping[:g]]).size == 0 && i.size == 5
    }.sort

    input_mapping[6] = input.find{|i|
        (i - [segment_mapping[:a],
            segment_mapping[:b],
            segment_mapping[:d],
            segment_mapping[:e],
            segment_mapping[:f],
            segment_mapping[:g]]).size == 0 && i.size == 6
    }.sort

    input_mapping[9] = input.find{|i|
        (i - [segment_mapping[:a],
            segment_mapping[:b],
            segment_mapping[:c],
            segment_mapping[:d],
            segment_mapping[:f],
            segment_mapping[:g]]).size == 0 && i.size == 6
    }.sort
    outputs << (output.map{ input_mapping.index(_1.sort) }*'').to_i
end

p outputs.sum