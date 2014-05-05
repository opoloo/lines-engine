atom_feed do |feed|
  feed.title CONFIG[:feed_title]
  feed.updated @articles.maximum(:updated_at)
  feed.logo CONFIG[:feed_logo]
  feed.icon CONFIG[:feed_favicon]

  @articles.each do |article|
    feed.entry article, url: article_url(article), published: article.published_at do |entry|
      entry.title article.title
      entry.summary type: 'xhtml' do |xhtml|
        xhtml << format_code(article.content)
      end
      entry.content type: 'xhtml' do |xhtml|
        xhtml << content_tag(:p,"<img src=\"#{article.image_url}\" alt=\"#{article.title}\"/>".html_safe).html_safe
        xhtml << markdown(article.content).html_safe
      end
      entry.author do |author|
        article.authors.each do |a|
          author.name a.name
        end
      end
      entry.contributor do |author|
        article.authors.each do |a|
          author.name a.name
        end
      end
    end
  end
end