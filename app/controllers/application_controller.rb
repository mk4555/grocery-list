require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, 'password'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
        User.find(session[:user_id])
      end
    end

    def logout
      session.clear
    end
  end
end
