require_relative "../hit_a_key"

filename=ARGV.first
lines=IO.readlines(filename).map(&:chomp)
sizes=[lines.first.size,lines.size]
puts "grid size #{sizes}"
@grid=Array.new(sizes.last){Array.new(sizes.first)}
lines.each_with_index do |line,y|
  line.chars.each_with_index do |c,x|
    @grid[y][x]=c.to_i
  end
end
@x,@y=*sizes

def visibles_from_left row
  ret=[]
  max=-1
  @grid[row].each_with_index do |v,x|
    if x > 0
      unless max >= v
        max = v
        ret << [row,x]
      end
    else
      max = v
      ret << [row,x]
    end
  end
  ret
end

def visibles_from_right row
  ret=[]
  max=-1
  @grid[row].reverse.each_with_index do |v,x|
    if x > 0
      unless max >= v
        ret << [row,@x-x-1]
        max = v
      end
    else
      max=v
      ret << [row,@x-x-1]
    end
  end
  ret
end

def visibles_from_up col
  ret=[]
  max=-1
  column=@grid.map{|row| row[col]}
  column.each_with_index do |v,y|
    if y > 0
      unless max >= v
        ret << [y,col]
        max=v
      end
    else
      max=v
      ret << [y,col]
    end
  end
  ret
end

def visibles_from_down col
  ret=[]
  max=-1
  column=@grid.map{|row| row[col]}
  column.reverse.each_with_index do |v,y|
    if y > 0
      unless max >= v
        ret << [@y-y-1,col]
        max=v
      end
    else
      max=v
      ret << [@y-y-1,col]
    end
  end
  ret
end

def compute
  visibles=[]
  for row in 0..@y-1
    visibles << visibles_from_left(row)
    visibles << visibles_from_right(row)
  end

  for col in 0..@x-1
    visibles << visibles_from_up(col)
    visibles << visibles_from_down(col)
  end
  return visibles.flatten(1).uniq
end

ret=compute()
p ret.size
