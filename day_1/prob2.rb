elves={}
id=1
IO.readlines("input.txt").each do |line|
    line.chomp!
    if line[/(\d+)/]
      elves[id]||=0
      elves[id]+=$1.to_i
    elsif line
      id+=1
    end
end

pp first_three=elves.sort_by{|id,total| total}.reverse[0..2].to_h
pp first_three.map{|k,v| v}.sum
