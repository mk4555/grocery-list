class ItemController < ApplicationController
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
      flash[:message] = "Please login to continue"
      redirect '/login'
    end
  end

  post '/items/new' do
    @item = Item.find_by(name: params[:item][:name])
    if @item == nil
      @item = Item.create(name: params[:item][:name])
    end
    current_user.items << @item
    if params[:item][:grocery_list_ids]
      @item.grocery_list_id = params[:item][:grocery_list_ids]
      params[:item][:grocery_list_ids].each do |id|
        list = GroceryList.find(id)
        list.items << @item
      end
      redirect "/#{current_user.slug}/grocery-lists"
    else
      redirect "/#{current_user.slug}/grocery-lists"
    end
  end

  post '/items/add' do
    if !params[:item][:name].empty?
      @item = Item.create(name: params[:item][:name])
      current_user.items << @item
      redirect "/#{current_user.slug}/grocery-lists/new"
    else
      flash[:message] = "Item requires a name"
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
end
