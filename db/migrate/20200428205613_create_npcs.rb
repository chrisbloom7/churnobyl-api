# frozen_string_literal: true
class CreateNpcs < ActiveRecord::Migration[6.0]
  def change
    create_table :npcs do |t|
      t.string :age
      t.string :attitude
      t.string :ethnicity
      t.string :gender
      t.string :origin

      t.timestamps
    end
  end
end
