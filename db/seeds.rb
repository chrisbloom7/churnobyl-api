# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rails.logger.debug 'Generating seed data'

if Collection.named('basic_npc').present?
  Rails.logger.debug 'Collection basic_npc already exists'
else
  Rails.logger.debug 'Creating basic_npc collection'

  templates = []
  templates << Template.new(label: 'First Name', generator: 'FirstName')
  templates << Template.new(label: 'Surname',    generator: 'HyphenatedSurname')
  templates << Template.new(label: 'Age',        generator: 'AgeGroup')
  templates << Template.new(label: 'Attitude',   generator: 'Attitude')
  templates << Template.new(label: 'Ancestry',   generator: 'MixedAncestry')
  templates << Template.new(label: 'Gender',     generator: 'GenderExpression')

  Collection.create!(name: 'basic_npc',
                     default_label: 'Basic NPC',
                     templates: templates)
end

if Collection.named('expanse_npc').present?
  Rails.logger.debug 'Collection expanse_npc already exists'
else
  Rails.logger.debug 'Creating expanse_npc collection'

  templates = []
  templates << Template.new(label: 'First Name', generator: 'FirstName')
  templates << Template.new(label: 'Surname',    generator: 'HyphenatedSurname')
  templates << Template.new(label: 'Age',        generator: 'AgeGroup')
  templates << Template.new(label: 'Attitude',   generator: 'Attitude')
  templates << Template.new(label: 'Ancestry',   generator: 'MixedAncestry')
  templates << Template.new(label: 'Gender',     generator: 'GenderExpression')
  templates << Template.new(label: 'Origin',     generator: 'Origin')

  Collection.create!(name: 'expanse_npc',
                     default_label: 'Expanse NPC',
                     templates: templates)
end

if Collection.named('statted_expanse_npc').present?
  Rails.logger.debug 'Collection statted_expanse_npc already exists'
else
  Rails.logger.debug 'Creating statted_expanse_npc collection'

  templates = []
  templates << Template.new(label: 'First Name', generator: 'FirstName')
  templates << Template.new(label: 'Surname',    generator: 'HyphenatedSurname')
  templates << Template.new(label: 'Age',        generator: 'AgeGroup')
  templates << Template.new(label: 'Attitude',   generator: 'Attitude')
  templates << Template.new(label: 'Ancestry',   generator: 'MixedAncestry')
  templates << Template.new(label: 'Gender',     generator: 'GenderExpression')
  templates << Template.new(label: 'Origin',     generator: 'Origin')

  templates << Template.new(label: 'Accuracy',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Communication',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Constitution',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Dexterity',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Fighting',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Intelligence',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Perception',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Strength',
                            generator: 'Age::AbilityScore')
  templates << Template.new(label: 'Willpower',
                            generator: 'Age::AbilityScore')

  Collection.create!(name: 'statted_expanse_npc',
                     default_label: 'Statted Expanse NPC',
                     templates: templates)

end

Rails.logger.debug 'Seeding complete'
