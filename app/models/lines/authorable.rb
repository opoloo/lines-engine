# {Authorable} associates one or more {Author}s to one or more {Article}s.

module Lines
  class Authorable < ActiveRecord::Base
    belongs_to :author
    belongs_to :article, touch: true
  end
end