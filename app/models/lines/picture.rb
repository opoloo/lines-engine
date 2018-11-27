# The content of an {Article} can contain multiple pictures.
# Pictures are associated to an article through parsing the articles
# content and extracting the ids of the used images.

require 'carrierwave'
require 'carrierwave/orm/activerecord'

module Lines  
  class Picture < Lines::ApplicationRecord
    # Associations    
    belongs_to :article, touch: true, optional: true

    # Mount carrierwave picture uploader
    mount_uploader :image, PictureUploader

    # Callbacks
    before_create :default_name

    # Returns the default name fo a picture
    def default_name
      self.name ||= File.basename(image.filename, '.*').titleize if image
    end

  end
end