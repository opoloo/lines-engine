atom_feed do |feed|
  feed.title CONFIG[:feed_title]
  feed.updated @articles.maximum(:updated_at)
  feed.logo CONFIG[:feed_logo]
  feed.icon CONFIG[:feed_favicon]

  @articles.each do |article|
    feed.entry article, url: article_url(article), published: article.published_at do |entry|
      entry.title article.title
      entry.summary type: 'xhtml' do |xhtml|
        if article.teaser.present?
          xhtml << markdown(article.teaser)
        else
          xhtml << format_code(article.content)
        end
      end
      entry.content type: 'xhtml' do |xhtml|
        xhtml << content_tag(:p,"<img src=\"#{article.absolute_image_url}\" alt=\"#{CGI.escape_html(article.title)}\"/>".html_safe).html_safe
        xhtml << markdown(article.content).html_safe
      end
      article.authors.each do |author|
        entry.author do |a|
          a.name author.name

        end        
      end
      article.authors.each do |author|
        entry.contributor do |a|
          a.name author.name
        end        
      end
    end
  end
end