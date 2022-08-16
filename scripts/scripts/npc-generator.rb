#!/usr/bin/env ruby

require_relative "../tables/gender"
require_relative "../tables/age"
require_relative "../tables/origin"
require_relative "../tables/ethnic_feature"
require_relative "../tables/attitude"

class Integer
  def d (die)
    sum = 0
    self.times do
      sum += rand(die) + 1
    end
    sum
  end
end

# def d6(times = 1)
#   rand(6) + 1
# end

def in_table_range(result, table)
  table[
    table.keys.detect do |range|
      if range.is_a?(Range)
        range.cover?(result)
      elsif range.is_a?(Array)
        range.include?(result)
      else
        range == result
      end
    end
  ]
end

gender = in_table_range 1.d(6), Gender::TABLE
age = in_table_range 1.d(6), Age::TABLE
origin = in_table_range 1.d(6), Origin::TABLE

ethinicities = []
(rand(3)+1).times do
  ethnicity = in_table_range 1.d(6), EthnicFeature::TABLE
  if (choices = ethnicity.split("/")).any?
    ethnicity = choices.sample
  end
  ethinicities << ethnicity
end

attitude = in_table_range 3.d(6), Attitude::TABLE

puts "Gender: #{gender}"
puts "Age: #{age}"
puts "Origin: #{origin}"
puts "Ethnicity: #{ethinicities.join("/")}"
puts "Attitude: #{attitude[:label]}"
