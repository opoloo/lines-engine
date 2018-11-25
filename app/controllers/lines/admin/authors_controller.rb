# Provides CRUD actions for +Author+ model.

require_dependency "lines/admin/application_controller"

module Lines
  module Admin
    class AuthorsController < ApplicationController

      # Listes all authroes
      def index
        @authors = Lines::Author.all
      end

      # Shows an author
      def show
        @author = Lines::Author.find(params[:id])
      end

      # New author
      def new
        @author = Lines::Author.new
      end

      # Edit an existing author
      def edit
        @author = Lines::Author.find(params[:id])
      end

      # Create a new author from params
      def create
        @author = Lines::Author.new(author_params)

        if @author.save
          redirect_to admin_author_path @author
        else
          render action: "new"
        end
      end

      # Update an existing author from params
      def update
        @author = Lines::Author.find(params[:id])

        if @author.update_attributes(author_params)
          redirect_to admin_author_path(@author)
        else
          render action: "edit"
        end
      end

      # Delete an author
      def destroy
        @author = Lines::Author.find(params[:id])
        if @author.destroy
          redirect_to admin_authors_url
        else
          @authors = Lines::Author.all
          render "index" 
        end
      end

      private

        # Use strong_params
        def author_params
          params.require(:author).permit(:email, :name, :description, :gplus_profile)
        end
    end

  end
end
