class ItemController < ApplicationController
  get '/items' do
    if logged_in?
      erb :'/items/index'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  get '/items/new' do
    if logged_in?
      erb :'/items/create_item'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  get '/items/:id' do
    @item = Item.find_by_id(params[:id])
    if current_user.id == @item.user_id
      erb :'/items/show_item'
    else
      flash[:notice] = "Please login to continue"
    end
  end

  post '/items/new' do
    @item = Item.create(params[:item])
    current_user.items << @item
    @item.save
    redirect "/items"
  end

  post '/items/add' do
    if !params[:item][:name].empty?
      @item = Item.create(name: params[:item][:name])
      current_user.items << @item
      redirect "/grocery-lists/new"
    else
      flash[:notice] = "Item requires a name"
      redirect "/grocery-lists/new"
    end
  end

  delete '/items/:id' do
    @item = Item.find_by_id(params[:id])
    if current_user.id == @item.user_id
      @item.delete
      redirect "/items"
    end
  end

  get '/items/:id/edit' do
    @item = Item.find_by_id(params[:id])
    if current_user.id == @item.user_id
      erb :'/items/edit_item'
    else
      flash[:notice] = "Please login to continue"
      redirect '/login'
    end
  end

  patch '/items/:id' do
    @item = Item.find_by_id(params[:id])
    if current_user.id == @item.user_id
      if !params[:item][:name].empty?
        @item.update(params[:item])
        @item.save
        redirect "/items/#{@item.id}"
      else
        flash[:notice] = "Item name cannot be empty!"
        redirect "/items/#{@item.id}/edit"
      end
    else
      flash[:notice] = "Please login to continue"
      redirect "/login"
    end
  end
end
