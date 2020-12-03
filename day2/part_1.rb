#!/usr/bin/env ruby
#
# The problem:
#   You've got a list of password policites and passwords.
#   Figure out how many of the passwords match their policy.
#
# Syntax:
#   1-3 a: abcde
#   |-| | |----|
#    |  |    |- The password to validate.
#    |  |- The letter to validate in the password.
#    |- How many times the letter can appear.

input_path = File.join(File.dirname(__FILE__), "input.txt")
input = File.read(input_path)
passwords_with_policies = input.split("\n").compact

def valid_password?(input)
  input = input.match /(?<min>\d*)-(?<max>\d*) (?<letter>\w): (?<password>\w*)/
  min, max = input[:min].to_i, input[:max].to_i
  letter, password = input[:letter], input[:password]

  password.count(letter).between?(min, max)
end

valid = passwords_with_policies.map { |pwp| valid_password?(pwp) }

puts "# of valid passwords: #{valid.count(true)}"
