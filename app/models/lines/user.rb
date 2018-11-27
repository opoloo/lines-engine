# {User}s are the administrators of a blog. 
# Since there is no interface to manage users, they have to be modified via
# Rails console. 
# 
# Examples:
#   rails c
#   # Create a new user:
#   User.create(email: 'mail@example.com', password: 'ultrasekret')
#   # Find a specific user and modify:
#   u = User.where(email: 'mail@example.com')
#   u.email = 'new@example.com'
#   u.password = 'newsecret'
#   u.save

module Lines

  class User < Lines::ApplicationRecord
    # Use bcrypt-ruby to encrypt passwords
    has_secure_password validations: false
    
    attr_accessor :reset_token

    # Validations
    validates :password, length: { minimum: 8 }, if: :validate_password?
    validates :password, presence: true, on: :create
    validates :email, uniqueness: true, presence: true

    # Sets +rest_digest+ and +reset_sent_at+ for password reset.
    def create_reset_digest
      self.reset_token = Lines::User.generate_token
      update_attribute(:reset_digest,  Lines::User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end

    # Sends email with instructions how to reset password.
    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end


    # Generate a random token.
    def User.generate_token
      SecureRandom.urlsafe_base64
    end

    # Returns the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns true if a password reset has expired.
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end


    private 
      # Returns +true+ if a password is submitted
      def validate_password?
        password.present?
      end

  end
end
