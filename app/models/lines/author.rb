# Each {Article} must have one or more {Author}s. 
# 
# An {Author} is unrelated to the currently logged in user. This allows to publish
# {Article}s by guest authors that don't need an own user account

module Lines
  class Author < Lines::ApplicationRecord
      
    # Relations
    has_many :authorables
    has_many :articles, through: :authorables
    
    # Validations
    validates :name, :email, :description, presence: true

    # Callbacks
    before_destroy :check_for_articles

    # Returns the first name 
    def first_name
    	self.name.split(" ").first
    end

    # Returns the last name
    def last_name
    	self.name.split(" ").last
    end

    private

      # Return false if an author has associated articles. 
      # This check is called before destroying an author to prevent leaving articles
      # without an associated author.
      def check_for_articles
        if articles.count > 0
          errors[:base] << "cannot delete author with existing blog articles"
          return false
        end
      end
  end
end