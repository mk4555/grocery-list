require 'rack-flash'
class GroceryListController < ApplicationController
  use Rack::Flash
  get '/grocery-lists' do
    redirect "/#{current_user.slug}/home"
  end

  get '/:slug/grocery-lists/new' do
    if logged_in?
      erb :'/grocery_lists/create_grocery_list'
    else
      flash[:message] = "You must login first"
      redirect '/login'
    end
  end

  post '/grocery-lists/new' do
    if !params[:name].empty?
      @grocery = GroceryList.create(params)
      @grocery.user_id = current_user.id
      @grocery.save
      redirect "/#{current_user.slug}/home"
    else
      flash[:message] = "Grocery List name cannot be empty"
      redirect "/#{current_user.slug}/grocery-lists/new"
    end
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
    @grocery = GroceryList.find(params[:id])
    if !params[:name].empty?
      @grocery.name = params[:name]
      @grocery.save
      redirect "#{current_user.slug}/grocery-lists/#{@grocery.id}"
    else
      flash[:message] = "Grocery List Name cannot be empty"
      redirect "#{current_user.slug}/grocery-lists/#{@grocery.id}/edit"
    end
  end

  delete '/grocery-lists/:id/delete' do
    @grocery = GroceryList.find_by_id(params[:id])
    if session[:user_id] == @grocery.user_id
      @grocery.delete
      redirect "/#{current_user.slug}/home"
    else
      redirect "/#{current_user.slug}/home"
    end
  end
end
