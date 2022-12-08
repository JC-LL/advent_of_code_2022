require_relative "../hit_a_key"

data=IO.read(ARGV.first).chomp.chars

fifo=[]
data.each_with_index do |c,idx|
  puts fifo.join("-")
  #hit_a_key
  if fifo.size == 4
    fifo.shift
  end
  fifo << c
  if fifo.size==4
    if fifo.uniq.size==4
      puts "found marker '#{fifo.join}' after reading #{idx+1} chars."
      exit
    end
  end
end
