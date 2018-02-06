require 'rack-flash'

class ItemController < ApplicationController
  use Rack::Flash

  get '/:slug/items' do
    if logged_in?
      erb :'/items/index'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  get '/:slug/items/new' do
    if logged_in?
      erb :'/items/create_item'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  get '/:slug/items/:id' do
    @item = Item.find_by_id(params[:id])
    if logged_in?
      erb :'/items/show_item'
    else
      flash[:notice] = "Please login to continue"
    end
  end



  post '/items/new' do
    @item = Item.create(params[:item])
    current_user.items << @item
    @item.save
    redirect "/#{current_user.slug}/items"
  end

  post '/items/add' do
    if !params[:item][:name].empty?
      @item = Item.create(name: params[:item][:name])
      current_user.items << @item
      redirect "/#{current_user.slug}/grocery-lists/new"
    else
      flash[:notice] = "Item requires a name"
      redirect "/#{current_user.slug}/grocery-lists/new"
    end
  end

  delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
    if current_user.id == @item.user_id
      @item.delete
      redirect "/#{current_user.slug}/items"
    end
  end

  get '/:slug/items/:id/edit' do
    if logged_in?
      @item = Item.find_by_id(params[:id])
      erb :'/items/edit_item'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  patch '/items/:id/edit' do
    @item = Item.find_by_id(params[:id])
    if !params[:item][:name].empty?
      @item.update(params[:item])
      @item.save
      redirect "/#{current_user.slug}/items/#{@item.id}"
    else
      flash[:notice] = "Item name cannot be empty!"
      redirect "/#{current_user.slug}/items/#{@item.id}/edit"
    end
  end
end
