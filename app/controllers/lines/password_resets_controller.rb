require_dependency "lines/application_controller"

module Lines
  class PasswordResetsController < ApplicationController

    layout 'lines/admin'

    before_action :get_user,   only: [:edit, :update]
    before_action :valid_user, only: [:edit, :update]

    def new
    end
  
    def create
      @user = User.find_by(email: params[:password_reset][:email].downcase)
      if @user
        @user.create_reset_digest
        @user.send_password_reset_email
      end
      flash[:success] = "Reset instructions have been sent to this email-address, if the user is registered."
      redirect_to root_url
    end

    def edit
    end

    def update
      if password_blank?
        flash.now[:error] = "Password can't be blank"
        render 'edit'
      elsif wrong_password_confirmation?
        flash.now[:error] = "Password confirmation does not match."
        render 'edit'
      elsif @user.update_attributes(user_params)
        # deletr reset_digest and reset_sent_at
        @user.update_attributes(reset_digest: nil, reset_sent_at: nil)        
        flash[:success] = "Password has been reset. You can now log in with the new password."
        redirect_to new_session_path
      else
        render 'edit'
      end
    end      


    private

      # Use strong_params
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      # Returns true if password is blank.
      def password_blank?
        params[:user][:password].blank?
      end

      def wrong_password_confirmation?
        params[:user][:password] != params[:user][:password_confirmation]
      end

      # Checks expiration of reset token.
      def check_expiration
        if @user.password_reset_expired?
          flash[:error] = "Password reset has expired."
          redirect_to new_password_reset_url
        end
      end

      def get_user
        @user = User.find_by(email: params[:email])
      end

      # Confirms a valid user.
      def valid_user
        unless (@user && @user.authenticated?(:reset, params[:id]))
          redirect_to root_url
        end
      end

  end
end
