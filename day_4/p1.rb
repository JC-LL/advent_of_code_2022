require_relative "../hit_a_key"

nb_covering=0
IO.readlines(ARGV.first).each do |line|
  pairs=line.chomp.split(',')
  range_pair=pairs.map{|pair| eval(pair.gsub('-','..'))}
  r1,r2=*range_pair
  if r1.cover?(r2) or r2.cover?(r1)
    nb_covering+=1
  end
end

puts "nb_covering = #{nb_covering}"
