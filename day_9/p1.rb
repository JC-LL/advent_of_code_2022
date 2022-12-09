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
end

def draw sx,sy,hpos,tpos
  lines=[]
  for y in 0..sy-1
    line=""
    for x in 0..sx-1
      if hpos.at?(x,y)
        line+="H"
      elsif tpos.at?(x,y)
        line+="T"
      else
        line+="."
      end
    end
    lines << line
  end
  puts lines.reverse.join("\n")
  puts
end

hpos=Point.new(0,0)
tpos=Point.new(0,0)

tpos_visits=[]

IO.readlines(ARGV.first).each do |line|
  line.chomp!
  line.match /([LRUD]) (\d+)/
  dir,val=$1,$2.to_i
  puts "cmd #{dir} #{val}".center(40,'=')
  val.times do |step|
    puts "step #{step}"
    case dir
    when 'U'
      hpos.y+=1
    when 'D'
      hpos.y-=1
    when 'L'
      hpos.x-=1
    when 'R'
      hpos.x+=1
    end

    dx=hpos.x-tpos.x
    dy=hpos.y-tpos.y

    if (dx*dy).abs > 1 # diagonals
      if dx>0
        tpos.x+=1
      elsif dx<0
        tpos.x-=1
      end
      if dy>0
        tpos.y+=1
      elsif dy<0
        tpos.y-=1
      end
    else
      if dx==2
        tpos.x+=1
      elsif dx==-2
        tpos.x-=1
      end
      if dy==2
        tpos.y+=1
      elsif dy==-2
        tpos.y-=1
      end
    end
    tpos_visits << tpos.to_s
    tpos_visits.uniq!

    draw(6,5,hpos,tpos)
  end
end

puts answer=tpos_visits.size
