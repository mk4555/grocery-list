class GroceryListController < ApplicationController
  get '/grocery-lists/new' do
    if logged_in?
      erb :'/grocery_lists/create_grocery_list'
    else
      #Flash you must be logged in message
      redirect '/login'
    end
  end

  post '/grocery-lists/new' do
    @grocery = GroceryList.create(params)
    @grocery.user_id = current_user.id
    @grocery.save
    redirect "/#{current_user.slug}/home"
  end

  get '/:slug/grocery-lists/:id' do
    @grocery = GroceryList.find(params[:id])
    erb :'/grocery_lists/show_grocery_list'
  end

  get '/:slug/grocery-lists/:id/edit' do
    @grocery = GroceryList.find(params[:id])
    erb :'/grocery_lists/edit_grocery_list'
  end

  patch '/grocery-lists/:id/edit' do
    if !params[:name].empty?
      @grocery = GroceryList.find(params[:id])
      @grocery.name = params[:name]
      @grocery.save
      redirect "#{current_user.slug}/grocery-lists/#{@grocery.id}"
    else
      # Flash message about empty parameter
      redirect "#{current_user.slug}/grocery-lists/#{@grocery.id}/edit"
    end
  end
end
