require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect "/home"
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
      redirect "/home"
    end
  end

  get '/login' do
    if logged_in?
      redirect " /home"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/home"
    else
      flash[:notice] = "Please make sure your username and password are correct"
      redirect "/login"
    end
  end

  get '/home' do
    if logged_in?
      @user = current_user
      erb :'/users/home'
    else
      flash[:notice] = "You must login first"
      redirect "/login"
    end
  end

  post '/logout' do
    if logged_in?
      logout
      redirect '/login'
    end
  end

end
