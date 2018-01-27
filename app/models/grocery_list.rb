class GroceryList < ActiveRecord::Base
  has_many :grocery_list_items
  has_many :items, through: :grocery_list_items
  belongs_to :user
end
