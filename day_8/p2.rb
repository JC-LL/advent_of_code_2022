require_relative "../hit_a_key"

filename=ARGV.first
lines=IO.readlines(filename).map(&:chomp)
sizes=[lines.first.size,lines.size]

@grid=Array.new(sizes.last){Array.new(sizes.first)}
lines.each_with_index do |line,y|
  line.chars.each_with_index do |c,x|
    @grid[y][x]=c.to_i
  end
end
@x,@y=*sizes

def nb_visible_trees_up x,y
  (y-1).downto(0) do |ym|
    if @grid[ym][x] >= @grid[y][x]
      return y-ym
    end
  end
  return y
end

def nb_visible_trees_down x,y
  (y+1).upto(@y-1) do |yp|
    if @grid[yp][x] >= @grid[y][x]
      return yp-y
    end
  end
  return @y-1-y
end

def nb_visible_trees_left x,y
  (x-1).downto(0) do |xm|
    if @grid[y][xm] >= @grid[y][x]
      return x-xm
    end
  end
  return x
end

def nb_visible_trees_right x,y
  (x+1).upto(@x-1) do |xp|
    if @grid[y][xp] >= @grid[y][x]
      return xp-x
    end
  end
  return (@x-1-x)
end

def score x,y
  scores=[]
  scores << nb_visible_trees_up(x,y)
  scores << nb_visible_trees_down(x,y)
  scores << nb_visible_trees_left(x,y)
  scores << nb_visible_trees_right(x,y)
  scenic_score=scores.inject(:*)
end

scenic_scores=[]
for y in 0..@y-1
  for x in 0..@x-1
    scenic_scores << score(x,y)
  end
end

puts scenic_scores.max
