# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Collection.find_by(name: "NPC")
  templates = []
  templates << Template.new(label: "First Name", generator: "FirstName")
  templates << Template.new(label: "Surname",    generator: "Surname")
  templates << Template.new(label: "Age",        generator: "AgeGroup")
  templates << Template.new(label: "Attitude",   generator: "Attitude")
  templates << Template.new(label: "Ancestry",   generator: "Ancestry")
  templates << Template.new(label: "Gender",     generator: "GenderExpression")
  templates << Template.new(label: "Origin",     generator: "Origin")
  Collection.create!(name: "npc",
                                  default_label: "NPC",
                                  templates: templates)
end
