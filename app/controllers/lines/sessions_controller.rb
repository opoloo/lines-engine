# Creates (login) and destroys (logout) sessions
require_dependency "lines/application_controller"

module Lines

  class SessionsController < ApplicationController

    layout "lines/admin"

    
    # Renders form for creating a new article 
    def new
    end

    # Authenticate user and create a new session.
    def create
      user = Lines::User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_root_url
      else
        flash.now[:error] = t('lines.login_error')
        render "new"
      end
    end

    # Destroys the current session (logout)
    def destroy
      session[:user_id] = nil
      redirect_to root_url
    end
  end

end