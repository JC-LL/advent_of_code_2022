require_relative "../hit_a_key"
class Point
  attr_accessor :x,:y
  def initialize x,y
    @x,@y=x,y
  end
  def to_s
    "(#{x},#{y})"
  end

  def at?(xx,yy)
    (x==xx) and (y==yy)
  end

  def pos
    [@x,@y]
  end
end

def draw sx,sy,snake
  lines=[]
  for y in 0..sy-1
    line=""
    for x in 0..sx-1
      if knot=snake.find{|knot| knot.at?(x,y)}
        case index=snake.index(knot)
        when 0
          line+="H"
        when 9
          line+="T"
        else
          line+=index.to_s
        end
      else
        line+="."
      end
    end
    lines << line
  end
  puts lines.reverse.join("\n")
  puts
end

def update snake
  for i in 1..9
    update_wrt(snake[i],snake[i-1])
  end
end

def update_wrt tail,head
  dx=head.x-tail.x
  dy=head.y-tail.y

  if (dx*dy).abs > 1 # diagonals
    if dx>0
      tail.x+=1
    elsif dx<0
      tail.x-=1
    end
    if dy>0
      tail.y+=1
    elsif dy<0
      tail.y-=1
    end
  else
    if dx==2
      tail.x+=1
    elsif dx==-2
      tail.x-=1
    end
    if dy==2
      tail.y+=1
    elsif dy==-2
      tail.y-=1
    end
  end
end

snake=Array.new(10){Point.new(12,5)}

tpos_visits=[snake[9].pos]

IO.readlines(ARGV.first).each do |line|
  line.chomp!
  line.match /([LRUD]) (\d+)/
  dir,val=$1,$2.to_i
  puts "cmd #{dir} #{val}".center(40,'=')
  val.times do |step|
    puts "step #{step}"
    case dir
    when 'U'
      snake[0].y+=1
    when 'D'
      snake[0].y-=1
    when 'L'
      snake[0].x-=1
    when 'R'
      snake[0].x+=1
    end

    update(snake)
    draw(28,21,snake)
    hit_a_key
    tpos_visits << snake.last.pos
    tpos_visits.uniq!
  end
end

puts answer=tpos_visits.size
