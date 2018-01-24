class CreateGroceryBags < ActiveRecord::Migration[5.1]
  def change
    create_table :grocery_bags do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
