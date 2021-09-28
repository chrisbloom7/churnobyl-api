# frozen_string_literal: true
class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.references :collection, null: false, foreign_key: true
      t.string :label
      t.string :generator

      t.timestamps
    end
  end
end
