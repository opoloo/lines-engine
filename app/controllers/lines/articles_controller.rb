# Lists all Articles and shows specific ones.
# Responds either to HTML and ATOM requests.
require_dependency "lines/application_controller"

module Lines

  class ArticlesController < ApplicationController

    layout 'lines/application'

    KEYWORDS = CONFIG[:keywords]
    SITE_TITLE = CONFIG[:title]

    # Lists all published articles.
    # Responds to html and atom
    def index
      respond_to do |format|
        format.html {
          @first_page = (params[:page] and params[:page].to_i > 0) ? false : true
          if params[:tag]
            @articles = Lines::Article.published.tagged_with(params[:tag]).page(params[:page].to_i)
          else
            @articles = Lines::Article.published.page(params[:page].to_i).padding(1)
          end
          
          if @articles.first_page?
            if @first_article = Article.published.first
              @first_article.teaser = nil unless @first_article.teaser.present?
            end
          end
          
          set_meta_tags title: SITE_TITLE,
                        description: CONFIG[:meta_description],
                        keywords: KEYWORDS,
                        open_graph: { title: SITE_TITLE,
                                        type: 'website',
                                        url: articles_url,
                                        site_name: SITE_TITLE,
                                        image: CONFIG[:og_logo]
                                      }

        }
        format.atom{
          @articles = Lines::Article.published
        }
      end
    end

    # Shows specific article
    def show
      @first_page = true
      @article = Lines::Article.published.find(params[:id])
      @article.teaser = nil unless @article.teaser.present?
      meta_tags = { title: @article.title,
        type: 'article',
        url: url_for(@article),
        site_name: SITE_TITLE,
      }
      meta_tags[:image] = CONFIG[:host] + @article.image_url if @article.image_url.present?
      set_meta_tags title: @article.title,
                    keywords: KEYWORDS + @article.tag_list.to_s,
                    open_graph: meta_tags
      if request.path != article_path(@article)
        return redirect_to @article, status: :moved_permanently
      end

      @related_articles = Lines::Article.published.where('id != ?', @article.id).order('').limit(2)
    end

  end

end
