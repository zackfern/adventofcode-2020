#!/usr/bin/env ruby
#

input_path = File.join(File.dirname(__FILE__), "input.txt")
input = File.read(input_path)
rows = input.split("\n").compact

slopes = [
  { slope: [1, 1], hit_trees: 0 },
  { slope: [3, 1], hit_trees: 0 },
  { slope: [5, 1], hit_trees: 0 },
  { slope: [7, 1], hit_trees: 0 },
  { slope: [1, 2], hit_trees: 0 }
]

slopes.each do |run|
  right, down = run[:slope]
  x = 0

  rows.each_with_index do |row, index|
    if index == 0
      next
    elsif down == 2 && index.odd?
      next
    end

    row = row.clone
    x = (x + right) % 31
    tile = row[x]

    case tile
    when nil
      break
    when "#"
      row[x] = "X"
      run[:hit_trees] += 1
    else
      row[x] = "O"
    end
  end
end

slopes.each do |run|
  puts <<~EOS
    Right #{run[:slope][0]}, down #{run[:slope][1]}
    🌲 Hit trees: #{run[:hit_trees]}
  EOS
end

the_answer = slopes.collect { |i| i[:hit_trees] }.reduce(:*)
puts "The answer: #{the_answer}"
