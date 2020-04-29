class RenameEthnicityToAncestry < ActiveRecord::Migration[6.0]
  def change
    change_table :npcs do |t|
      t.rename :ethnicity, :ancestry
    end
  end
end
