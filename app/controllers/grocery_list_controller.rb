class GroceryListController < ApplicationController
  get '/grocery-lists/new' do
    erb :'/grocery_lists/create_grocery_list'
  end
end
