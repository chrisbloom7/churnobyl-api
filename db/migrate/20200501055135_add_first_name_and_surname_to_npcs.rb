class AddFirstNameAndSurnameToNPCs < ActiveRecord::Migration[6.0]
  def change
    add_column :npcs, :first_name, :string
    add_column :npcs, :surname, :string
  end
end
