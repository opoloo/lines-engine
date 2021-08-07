# Handles file uploads for content pictures.
require_dependency "lines/admin/application_controller"

module Lines
  module Admin

    class PicturesController < ApplicationController
      def create
        @picture = Lines::Picture.create(picture_params)
      end

      # PUT /admin/pictures/1
      def update
        @picture = Lines::Picture.find(params[:id])

        respond_to do |format|
          if @picture.update(picture_params[:picture])
            format.html { redirect_to @picture }
          else
            format.html { render action: "edit" }
          end
        end
      end

      # Deletes a picture. Only responds to JS requests.
      def destroy
        @picture = Lines::Picture.find(params[:id])
        @picture.destroy

        respond_to do |format|
          format.js
        end
      end

      private

        # strong_params
        def picture_params
          params.fetch(:picture, {}).permit(:image)
        end
    end
  
  end
end
