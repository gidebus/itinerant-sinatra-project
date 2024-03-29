class UsersController < ApplicationController
 
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/signup' do
        if !logged_in?
            erb :'/users/signup'
        else
          redirect to '/places'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            flash[:message] = "Values cannot be blank."
            redirect to '/signup'
        else
          @user = User.create(params)
          session[:user_id] = @user.id
          redirect to '/places'
        end
    end

    get '/login' do
        if !logged_in?
          erb :'/users/login'
        else
          redirect to '/places'
        end
    end
    
    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/places'
        else
            redirect to '/login'
        end
    end
    
    get '/logout' do
        if logged_in?
            session.clear
            redirect to  '/login'
        else
            redirect to '/'
        end
    end


end