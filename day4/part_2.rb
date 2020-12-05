#!/usr/bin/env ruby
#
# The problem: You've got a batch list of "passports"
# Scan over the file and see how many of them are valid.
#
# To be valid, a passport needs the following fields:
#   - byr
#   - iyr
#   - eyr
#   - hgt
#   - hcl
#   - ecl
#   - pid
#   - cid
# The passport must have all fields, but `cid` is optional, maybe?
#
# But wait, now we have to validate the fields themselves instead of just their presence! Gasp!
#
# Each passport is represented as a sequence of key:value pairs
# separated by spaces or newlines.
# Passports are separated by blank lines.

input_path = File.join(File.dirname(__FILE__), "input.txt")
file = File.read(input_path)

valid_passports = 0
REQUIRED_FIELDS = %w(byr iyr eyr hgt hcl ecl pid)

class Passport
  attr_reader :passport

  def initialize(passport)
    @passport = passport
  end

  def valid?
    @passport.delete "cid"

    @passport.keys.sort == REQUIRED_FIELDS.sort && \
      @passport.all? do |key, value|
        valid_field?(key, value)
      end
  end

  def valid_field?(field, value)
    case field
    when "byr"
      value.to_i.between?(1920, 2002)
    when "iyr"
      value.to_i.between?(2010, 2020)
    when "eyr"
      value.to_i.between?(2020, 2030)
    when "hgt"
      # If cm, the number must be at least 150 and at most 193.
      # If in, the number must be at least 59 and at most 76.
      unit = value[-2..-1]
      if unit == "cm"
        value.to_i.between?(150, 193)
      elsif unit == "in"
        value.to_i.between?(59, 76)
      end
    when "hcl"
      # a # followed by exactly six characters 0-9 or a-f.
      value.match? /#[0-9a-f]{6}/
    when "ecl"
      %w(amb blu brn gry grn hzl oth).include?(value)
    when "pid"
      # a nine-digit number, including leading zeroes.
      value.match? /^\d{9}$/
    else
      false
    end
  end
end

this_passport = {}
file.each_line do |line|
  if line == "\n"
    valid_passports += 1 if Passport.new(this_passport).valid?
    this_passport = {}
  else
    results = line.scan /((?<k>\S*):(?<v>\S*))\s/
    this_passport.merge!(results.to_h)
  end
end

unless this_passport.empty?
  valid_passports += 1 if Passport.new(this_passport).valid?
end

puts "# of valid passports: #{valid_passports}"
