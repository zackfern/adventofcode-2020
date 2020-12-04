#!/usr/bin/env ruby
#

input_path = File.join(File.dirname(__FILE__), "input.txt")
input = File.read(input_path)
rows = input.split("\n").compact

RIGHT, DOWN = 3, 1
hit_trees = 0

x = 0
rows.each_with_index do |row, index|
  if index == 0
    row[index] = "O"
    puts row
    next
  end

  x = (x + RIGHT) % 31
  tile = row[x]

  case tile
  when nil
    break
  when "#"
    row[x] = "X"
    hit_trees += 1
  else
    row[x] = "O"
  end

  puts row
  # puts "index: #{index} / x: #{x} / tile: #{tile}"
end

puts "Hit trees: #{hit_trees}"
