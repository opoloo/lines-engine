module Lines
  class UserMailer < ActionMailer::Base
    default from: CONFIG[Rails.env.to_sym]['from_email']
    
    def password_reset(user)
      @user = user
      mail to: user.email, subject: "Forgot your LINES password?"
    end

  end
end
