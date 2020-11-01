module Lines
  class ApplicationController < ActionController::Base
    around_action :switch_locale
 
    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end

    def default_url_options
      { locale: I18n.locale }
    end

    private

    def current_lines_user
      @current_lines_user ||= Lines::User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_lines_user

    def authorize
      redirect_to login_url, notice: t('lines.please_login') if current_lines_user.nil?
    end
  end
end
