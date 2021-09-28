# frozen_string_literal: true

class AddFirstNameAndSurnameToNPCs < ActiveRecord::Migration[6.0]
  def change
    change_table :npcs, bulk: true do
      t.string :first_name
      t.string :surname
    end
  end
end
