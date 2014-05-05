# Creates (login) and destroys (logout) sessions
require_dependency "lines/application_controller"

module Lines

  class SessionsController < ApplicationController

    layout "admin"

    
    # Renders form for creating a new article 
    def new
    end

    # Authenticate user and create a new session.
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_root_url, notice: "Logged in!"
      else
        flash.now.alert = "Email or password is invalid"
        render "new"
      end
    end

    # Destroys the current session (logout)
    def destroy
      session[:user_id] = nil
      redirect_to root_url, notice: "Logged out!"
    end
  end

end