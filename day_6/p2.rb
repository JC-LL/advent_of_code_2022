require_relative "../hit_a_key"

data=IO.read(ARGV.first).chomp.chars

fifo=[]
data.each_with_index do |c,idx|
  puts fifo.join("-")
  #hit_a_key
  if fifo.size == 14
    fifo.shift
  end
  fifo << c
  if fifo.size==14
    if fifo.uniq.size==14
      puts "found marker '#{fifo.join}' after reading #{idx+1} chars."
      exit
    end
  end
end
