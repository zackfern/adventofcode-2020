#!/usr/bin/env ruby
#
# Not a performance concern in sight, just vibing.
#
# The problem:
#   You've got a list of numbers as input.
#   In this list, find the two entries that sum up to 2020
#   Multiple those together.
#   That's your answer.

input_path = File.join(File.dirname(__FILE__), "input.txt")
input = File.read(input_path)
numbers = input.split.map(&:to_i)

number_one, number_two = nil, nil

numbers.each do |number|
  this_plus_everything = numbers.map { |another_number| another_number + number }
  index = this_plus_everything.index(2020)

  if index
    number_one = number
    number_two = numbers[index]

    puts "I am #{number} at my partner is #{number_two}"
    break # Don't loop anymore, we got this.
  end
end

puts "The answer is: #{number_one * number_two}"
