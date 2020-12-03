#!/usr/bin/env ruby
#
# The problem:
#   > Each policy describes two positions in the password,
#   > where 1 means the first character, 2 means the second character, and so on.
#   > Exactly one of these positions must contain the given letter.
#   > Other occurrences of the letter are irrelevant for the purposes of policy enforcement.
#
# Syntax:
#   1-3 a: abcde
#   |-| | |----|
#    |  |    |- The password to validate.
#    |  |- The letter to validate in the password.
#    |- Positions where the letter must exist.

input_path = File.join(File.dirname(__FILE__), "input.txt")
input = File.read(input_path)
passwords_with_policies = input.split("\n").compact

def valid_password?(input)
  input = input.match /(?<min>\d*)-(?<max>\d*) (?<letter>\w): (?<password>\w*)/
  i1, i2 = input[:min].to_i - 1, input[:max].to_i - 1
  letter, password = input[:letter], input[:password]

  letters_at_index = [password[i1], password[i2]]
  return false if letters_at_index.all? { |l| l == letter }
  letters_at_index.any? { |l| l == letter }
end

valid = passwords_with_policies.map { |pwp| valid_password?(pwp) }

puts "# of valid passwords: #{valid.count(true)}"
