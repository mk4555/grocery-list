class Item < ActiveRecord::Base
  has_many :grocery_list_items
  has_many :grocery_lists, through: :grocery_list_items
  belongs_to :user
end
