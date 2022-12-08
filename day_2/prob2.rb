SHAPE_SCORE={
  'A' => 1,
  'B' => 2,
  'C' => 3
}

HOW_TO={
  ['A','X'] => 'C',
  ['A','Y'] => 'A',
  ['A','Z'] => 'B',
  ['B','X'] => 'A',
  ['B','Y'] => 'B',
  ['B','Z'] => 'C',
  ['C','X'] => 'B',
  ['C','Y'] => 'C',
  ['C','Z'] => 'A',
}
score=0
IO.readlines(ARGV.first).each do |line|
  him,me=line.split
  score+=SHAPE_SCORE[ HOW_TO[[him,me]] ]
  case me
  when 'X'
    score+=0
  when 'Y'
    score+=3
  when 'Z'
    score+=6
  end
end
puts "score=#{score}"
