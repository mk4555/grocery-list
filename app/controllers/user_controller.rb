class UserController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect "/#{current_user.slug}/home"
    else
      erb :'/users/create_user'
    end

  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect "/#{@user.slug}/home"
  end

  get '/login' do
    if logged_in?
      redirect "/#{current_user.slug}/home"
    else
      erb :'/users/login'
    end
  end

  post '/login' do

  end

  get '/:slug/home' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/home'
  end


end
