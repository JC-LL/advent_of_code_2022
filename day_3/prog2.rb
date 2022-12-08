VALUE_OF=[('a'..'z').to_a,('A'..'Z').to_a].flatten.map.with_index{|i,idx| [i,idx+1]}.to_h

score=0
lines=IO.readlines(ARGV.first).map(&:chomp)
groups=lines.each_slice(3).to_a
groups.each do |group|
  common_letter=group.map(&:chars).inject{|t,inter| inter.intersection(t)}.first
  score+=VALUE_OF[common_letter]
end

puts "score=#{score}"
