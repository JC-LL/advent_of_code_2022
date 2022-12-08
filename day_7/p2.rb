Cd=Struct.new(:dest)
Ls=Struct.new(:dummy)
# results :
ResDir=Struct.new(:name)
ResFic=Struct.new(:size,:name)

# parse returns an array of commands hash : [ {command => [results]}* ]
def parse lines
  commands=[]
  lines.each do |line|
    line.chomp!
    case line
    when /\$ (.*)/
      cmd=$1
      case cmd
      when /cd (.*)/
        cmd=Cd.new($1)
      when /ls/
        cmd=Ls.new
      end
      commands << {cmd => []}
    else
      case line
      when /(\d+) (\w+)/
        e=ResFic.new($1.to_i,$2)
      when /dir (\w+)/
        e=ResDir.new($1)
      end
      last_h=commands.last
      command=last_h.keys.first
      last_h[command] << e
    end
  end
  commands
end


require_relative "../hit_a_key"
filename=ARGV.first
lines=IO.readlines(filename)
commands=parse(lines)

Dir=Struct.new(:name,:elements,:size,:predecessor)
Fic=Struct.new(:name,:size)

root=Dir.new("/",[],0,nil)
current=nil
nodes_h={"/"=>root}

def path dir
  if dir.predecessor
    return path(dir.predecessor)+"/"+dir.name
  else
    return "/"
  end
end

commands.each do |cmd_res_h|
  cmd,results=*cmd_res_h.first
  puts "executing #{cmd}"
  case cmd
  when Cd
    case cmd.dest
    when ".."
      current=current.predecessor
    when "/"
      current=root
    else
      dest=path(current)+"/"+cmd.dest
      current=nodes_h[dest]
    end
    puts "in "+path(current)
  when Ls
    results.each do |res|
      case rep=fic=res
      when ResFic
        current.elements << fic=Fic.new(fic.name,fic.size)
      when ResDir
        current.elements << rep=Dir.new(rep.name,[],nil,current)
        fullname=path(current)+"/"+rep.name
        nodes_h[fullname]=rep
      end
    end
    puts current.elements.map{|e|e}
  end
end

def sizeof dir
  sum=0
  dir.elements.each do |e|
    case e
    when Dir
      sum+=sizeof(e)
    when Fic
      sum+=e.size
    end
  end
  puts path(dir)+" : size #{sum}"
  dir.size=sum
  return sum
end

sizeof(root)

DISK_SIZE=70000000
NEEDED_SIZE=30000000
used=sizeof(root)
avail=DISK_SIZE-used
@target_dir_size=NEEDED_SIZE - avail

def find_candidates dir
  ret=[]
  dir.elements.each do |e|
    case dir=e
    when Dir
      ret << dir if dir.size >= @target_dir_size
      ret << find_candidates(e)
    end
  end
  ret.flatten.uniq
end

candidates=find_candidates(root)
puts "candidates".center(80,'=')
candidates.each do |candidate|
  puts "#{path(candidate)} : #{candidate.size}"
end

res=candidates.min_by{|cand| cand.size}
puts "suggest to delete #{path(res)} : #{res.size}"
