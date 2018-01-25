class ItemController < ApplicationController
  post '/items/new' do
    @item = Item.create(name: params[:item_name])
    redirect "/#{current_user.slug}/grocery-lists/new"
  end
end
