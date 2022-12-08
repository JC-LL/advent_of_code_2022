def hit_a_key
  print "hit_a_key !"
  $stdin.gets
end

SHAPE_SCORE={
  'A' => 1,
  'B' => 2,
  'C' => 3
}
WINNER={
  ['A','A'] => :draw,
  ['A','B'] => :me,
  ['A','C'] => :him,
  ['B','A'] => :him,
  ['B','B'] => :draw,
  ['B','C'] => :me,
  ['C','A'] => :me,
  ['C','B'] => :him,
  ['C','C'] => :draw,
}
score=0
IO.readlines(ARGV.first).each do |line|
  line.gsub!('X','A')
  line.gsub!('Y','B')
  line.gsub!('Z','C')
  him,me=line.split
  score+=SHAPE_SCORE[me]
  case WINNER[[him,me]]
  when :me
    score+=6
  when :him
    score+=0
  when :draw
    score+=3
  end
end
puts "score=#{score}"
