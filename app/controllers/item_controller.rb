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
    @item = Item.create(name: params[:name])
    redirect "/#{current_user.slug}/grocery-lists/new"
  end
end
