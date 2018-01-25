class ItemController < ApplicationController
  get '/items/new' do
    if logged_in?
      erb :'/items/create_item'
    else
      flash[:message] = "Please login to continue"
      redirect '/login'
    end
  end

  post '/items/new' do
    @item = Item.create(name: params[:item][:name])
    @item.grocery_list_id = params[:item][:grocery_list_ids]
    params[:item][:grocery_list_ids].each do |id|
      list = GroceryList.find(id)
      list.items << @item
    end
    @item.user_id = current_user.id
    redirect "/#{current_user.slug}/grocery-lists/new"
  end

  post '/items/add' do
    if !params[:item][:name].empty?
      @item = Item.create(name: params[:item][:name])
      redirect "/#{current_user.slug}/grocery-lists/new"
    else
      flash[:message] = "Item requires a name"
      redirect "/#{current_user.slug}/grocery-lists/new"
    end
  end
end
