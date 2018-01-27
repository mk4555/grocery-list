class CreateGroceryListItems < ActiveRecord::Migration[5.1]
  def change
    create_table :grocery_list_items do |t|
      t.integer :grocery_list_id
      t.integer :item_id
    end
  end
end
