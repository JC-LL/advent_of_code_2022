elves={}
id=1
IO.readlines("input.txt").each do |line|
    puts line.chomp!
    if line[/(\d+)/]
      elves[id]||=0
      elves[id]+=$1.to_i
    elsif line
      id+=1
    end
end

pp elves.max_by{|id,total| total}
