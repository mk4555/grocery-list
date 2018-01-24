class Item < ActiveRecord::Base
  belongs_to :grocery_lists
  belongs_to :users
end
