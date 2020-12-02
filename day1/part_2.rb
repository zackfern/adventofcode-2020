#!/usr/bin/env ruby
#
# Not a performance concern in sight, just vibing.
#
# The problem:
#   You've got a list of numbers as input.
#   In this list, find the THREE entries that sum up to 2020
#   Multiple those three together.
#   That's your answer.

input_path = File.join(File.dirname(__FILE__), "input.txt")
input = File.read(input_path)
numbers = input.split.map(&:to_i)

numbers.each do |number|
  potential_friends = numbers.select { |i| i + number < 2020 }

  if potential_friends.length > 1
    potential_friends.each do |friend|
      sumz = potential_friends.map { |i| i + friend + number }
      found_it = sumz.index(2020)
      if found_it
        third = potential_friends[found_it]
        puts "Found it! #{number} + #{friend} + #{third} = #{number+friend+third}"
        puts "The answer is #{number*friend*third}"

        exit # Fuck proper flow control, right?
      end
    end
  end
end
