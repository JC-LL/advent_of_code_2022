require 'strscan'
require_relative "../hit_a_key"

def parse_stacks filename
  stacks=[]
  IO.readlines(filename).each do |line|
    line.chomp!
    return stacks if line=~/\d/
    sc=StringScanner.new(line)
    while sc.rest?
      sc.skip_until(/\[([A-Z])\]/)
      packet=sc.matched.match(/([A-Z])/)[0]
      column=sc.pos / 4 + 1
      stacks[column]||=[]
      stacks[column].unshift packet
    end
  end
  stacks.map(&:reverse)
end

def parse_orders filename
  orders=IO.readlines(filename).select{|line| line.start_with? "move"}.map(&:chomp)
  orders.map do |order|
    md=order.match(/move (\d+) from (\d+) to (\d+)/)
    md.captures.map(&:to_i)
  end
end

def run stacks,orders
  orders.each do |order|
    nb,src,dest=*order
    nb.times do
      packet=stacks[src].pop
      stacks[dest] << packet
    end
  end
  stacks
end

stacks=parse_stacks(ARGV.first)
orders=parse_orders(ARGV.first)
stacks=run(stacks,orders)
puts stacks[1..-1].map{|stack| stack.last}.join
