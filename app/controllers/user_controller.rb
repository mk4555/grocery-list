require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect "/#{current_user.slug}/home"
    else
      erb :'/users/create_user'
    end

  end

  post '/signup' do
    @user = User.find_by(username: params[:username])
    if @user
      flash[:notice] = "#{@user.username} already exists, please try a different one"
      redirect '/signup'
    elsif params[:username].empty? || params[:password].empty?
      flash[:notice] = "Please enter both a username and a password"
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/#{@user.slug}/home"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/#{current_user.slug}/home"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/#{@user.slug}/home"
    else
      flash[:notice] = "Please make sure your username and password are correct"
      redirect "/login"
    end
  end

  get '/:slug/home' do
    if logged_in? && current_user.username == params[:slug].gsub('-',' ')
      @user = User.find_by_slug(params[:slug])
      erb :'/users/home'
    else
      flash[:message] = "You must login first"
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      logout
      flash[:message] = "You have been logged out"
      redirect '/login'
    else
      flash[:message] = "You must login first"
      redirect '/login'
    end
  end

end
