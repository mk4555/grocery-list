require 'rack-flash'
class GroceryListController < ApplicationController
  use Rack::Flash
  get '/grocery-lists' do
    if logged_in?
      erb :'/grocery_lists/index'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  get '/grocery-lists/new' do
    if logged_in?
      erb :'/grocery_lists/create_grocery_list'
    else
      flash[:notice] = "You must login first"
      redirect '/login'
    end
  end

  post '/grocery-lists/new' do
    if !params[:grocery_list][:name].empty?
      @grocery = GroceryList.create(params[:grocery_list])
      @grocery.user_id = current_user.id
      @grocery.save
      redirect "/home"
    else
      flash[:notice] = "Grocery List name cannot be empty"
      redirect "/grocery-lists/new"
    end
  end

  get '/grocery-lists/:id' do
    @grocery = GroceryList.find(params[:id])
    if @grocery.user == current_user
      erb :'/grocery_lists/show_grocery_list'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  get '/grocery-lists/:id/edit' do
    @grocery = GroceryList.find(params[:id])
    if @grocery.user == current_user
      erb :'/grocery_lists/edit_grocery_list'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  patch '/grocery-lists/:id' do
    @grocery = GroceryList.find(params[:id])
    if @grocery.user == current_user
      if !params[:grocery_list][:name].empty?
        @grocery.update(params[:grocery_list])
        @grocery.save
        redirect "/grocery-lists/#{@grocery.id}"
      else
        flash[:notice] = "Grocery List Name cannot be empty"
        redirect "/grocery-lists/#{@grocery.id}/edit"
      end
    end
  end

  delete '/grocery-lists/:id' do
    @grocery = GroceryList.find_by_id(params[:id])
    if @grocery.user == current_user
      @grocery.delete
      redirect "/grocery-lists"
    end
  end
end
