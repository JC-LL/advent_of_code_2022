VALUE_OF=[('a'..'z').to_a,('A'..'Z').to_a].flatten.map.with_index{|i,idx| [i,idx+1]}.to_h

score=0
IO.readlines(ARGV.first).each do |line|
  line.chomp!
  half_pos=line.size/2
  parts=[line.slice(0..half_pos-1),line.slice(half_pos..-1)]
  parts_chars=parts.map{|str| str.chars}
  common_letter=parts_chars.first.intersection(parts_chars.last).first
  val=VALUE_OF[common_letter]
  score+=val
end
puts "score=#{score}"
