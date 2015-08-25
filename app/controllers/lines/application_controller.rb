module Lines
  class ApplicationController < ActionController::Base

    private

      # sets the current_lines_user if one exists in session
      def current_lines_user
        @current_lines_user ||= Lines::User.find(session[:user_id]) if session[:user_id]
      end
      helper_method :current_lines_user

      # checks if current user is authorized. Redirects to login_url if not
      def authorize
        redirect_to login_url, notice: t('lines.please_login') if current_lines_user.nil?
      end

  end
end
