class AddTeaserToArticle < ActiveRecord::Migration[4.2]
  def change
    add_column :lines_articles, :teaser, :text
  end
end
