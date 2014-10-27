class AddTeaserToArticle < ActiveRecord::Migration
  def change
    add_column :lines_articles, :teaser, :text
  end
end
