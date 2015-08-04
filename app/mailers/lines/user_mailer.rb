module Lines
  class UserMailer < ActionMailer::Base
    default from: CONFIG[:production]['from_email']
    
    def password_reset(user)
      @user = user
      mail to: user.email, subject: "Forgot your LINES password?"
    end

  end
end
