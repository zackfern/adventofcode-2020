#!/usr/bin/env ruby
#
# The problem: You've got a batch list of "passports"
# Scan over the file and see how many of them are valid.

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
# Each passport is represented as a sequence of key:value pairs
# separated by spaces or newlines.
# Passports are separated by blank lines.

input_path = File.join(File.dirname(__FILE__), "input.txt")
file = File.read(input_path)

@valid_passports = 0
REQUIRED_FIELDS = %w(byr iyr eyr hgt hcl ecl pid)

def valid_passport?(passport)
  passport_fields = passport.keys
  passport_fields.delete "cid"

  if passport_fields.sort == REQUIRED_FIELDS.sort
    @valid_passports += 1
  end
end

this_passport = {}
file.each_line do |line|
  if line == "\n"
    valid_passport?(this_passport)
    this_passport = {}
  else
    results = line.scan /((?<k>\S*):(?<v>\S*))\s/
    this_passport.merge!(results.to_h)
  end
end

valid_passport?(this_passport) unless this_passport.empty?
puts "# of valid passports: #{@valid_passports}"
