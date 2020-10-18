# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Generating seed data"

unless Collection.named("npc").present?
  puts "Creating npc collection"

  templates = []
  templates << Template.new(label: "First Name", generator: "FirstName")
  templates << Template.new(label: "Surname",    generator: "HyphenatedSurname")
  templates << Template.new(label: "Age",        generator: "AgeGroup")
  templates << Template.new(label: "Attitude",   generator: "Attitude")
  templates << Template.new(label: "Ancestry",   generator: "MixedAncestry")
  templates << Template.new(label: "Gender",     generator: "GenderExpression")
  templates << Template.new(label: "Origin",     generator: "Origin")
  Collection.create!(name: "npc",
                     default_label: "NPC",
                     templates: templates)
else
  puts "npc collection already exists"
end

unless Collection.named("statted_npc").present?
  puts "Creating statted_npc collection"

  templates = []
  templates << Template.new(label: "First Name", generator: "FirstName")
  templates << Template.new(label: "Surname",    generator: "HyphenatedSurname")
  templates << Template.new(label: "Age",        generator: "AgeGroup")
  templates << Template.new(label: "Attitude",   generator: "Attitude")
  templates << Template.new(label: "Ancestry",   generator: "MixedAncestry")
  templates << Template.new(label: "Gender",     generator: "GenderExpression")
  templates << Template.new(label: "Origin",     generator: "Origin")

  templates << Template.new(label: "Accuracy",      generator: "AbilityScore")
  templates << Template.new(label: "Communication", generator: "AbilityScore")
  templates << Template.new(label: "Constitution",  generator: "AbilityScore")
  templates << Template.new(label: "Dexterity",     generator: "AbilityScore")
  templates << Template.new(label: "Fighting",      generator: "AbilityScore")
  templates << Template.new(label: "Intelligence",  generator: "AbilityScore")
  templates << Template.new(label: "Perception",    generator: "AbilityScore")
  templates << Template.new(label: "Strength",      generator: "AbilityScore")
  templates << Template.new(label: "Willpower",     generator: "AbilityScore")

  Collection.create!(name: "statted_npc",
                     default_label: "Statted NPC",
                     templates: templates)

else
  puts "statted_npc collection already exists"
end

puts "Seeding complete"
