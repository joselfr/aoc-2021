vents = File.read("input.txt").scan(/\d+/).map(&:to_i).each_slice(4).to_a

#
# Remove vertical vents
#
vents.filter!{|x1,y1,x2,y2| x1 == x2 || y1 == y2}

#
# Define all lines points
#
points = vents.map{ |x1,y1,x2,y2| 
    xstep = (x2 <=> x1)
    ystep = (y2 <=> y1)

    ipoints = []
    xstart = x1
    ystart = y1
    while xstart != x2 || ystart != y2
        ipoints << [xstart,ystart]
        xstart += xstep
        ystart += ystep
    end
    ipoints << [xstart, ystart]
    ipoints
}

p points.flatten.each_slice(2).tally.count{|k,v| v > 1}