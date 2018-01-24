class GroceryListController < ApplicationController
  get '/grocery-lists/new' do
    erb :'/grocery_lists/create_grocery_list'
  end

  post '/grocery-lists/new' do
    @grocery = GroceryList.create(params)
    @grocery.user_id = current_user.id
    @grocery.save
    redirect "/#{current_user.slug}/home"
  end
end
