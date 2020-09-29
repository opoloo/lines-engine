require 'redcarpet'
require 'pygments'
# encoding: utf-8
# Provides helper methods for views.
module Lines
  module ApplicationHelper

    # Renders the teaser for an article. 
    def render_teaser(article, article_counter=0)
      if article_counter < 0
        teaser = article.teaser && article.teaser.present? ? markdown(article.teaser) : nil
      else
        teaser = article.teaser && article.teaser.present? ? format_code(article.teaser) : format_code(article.content)
      end
      teaser
    end

    # Highlights and formats code fragments with Pygments 
    class HTMLwithPygments < Redcarpet::Render::XHTML
      def block_code(code, language)
        sha = Digest::SHA1.hexdigest(code)
        Rails.cache.fetch ["code", language, sha].join('-') do
          begin
            Pygments.highlight(code, lexer: language)
          rescue => e
            "<div class=\"highlight\"><pre>#{code}</pre></div>"
          end
        end
      end
    end

    # Returns formatted and highlighted code fragments
    def markdown(text)
      renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: false, with_toc_data: false)
      options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        tables: true,
        strikethrough: true,
        superscript: true,
        xhtml: true
      }
      Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end

    # Returns links in active or inactive state for highlighting current page
    def nav_link(link_text, link_path)
      recognized = Rails.application.routes.recognize_path(link_path)
      class_name = recognized[:controller] == params[:controller] ? 'active' : ''
      content_tag(:li, class: class_name) do
        link_to link_text, link_path
      end
    end

    # Returns HTML with all authors of an article
    def display_article_authors(article, with_info=false)
      authors = article.authors.map{|author| author.gplus_profile.blank? ? author.name : link_to(author.name, author.gplus_profile)}.to_sentence(two_words_connector: " & ", last_word_connector: " & ").html_safe
      if with_info
        authors += (" — " + article.authors.map{|author| content_tag(:span, "#{author.description}", class: 'author_description') }.join(" — ")).html_safe
      end
      authors
    end

    # Renders the navigation bar for logged in users
    def render_navbar(&block)
      action_link = get_action_link
      if !action_link
        action_link = CONFIG[:title_short]
      end
      html = content_tag(:div, id: 'navbar') do
        content_tag(:div, class: 'navbar-inner') do
          if current_lines_user
            content_tag(:span, class: 'buttons', &block) + "<div class='btn-menu'><div class='stripes'></div></div>".html_safe + 
            "<div class='submenu'>
              <div class='submenu-inner'>
                <ul>
                  <li>#{link_to("Dashboard", admin_articles_path)}</li>
                  <li>#{link_to(t('activerecord.models.lines/author', count: 2).html_safe, admin_authors_path)}</li>
                </ul>
                <ul>
                  <li class='small'>#{t('lines.logged_in_as').html_safe} #{current_lines_user.email}</li>
                  <li>#{link_to(t('lines.buttons.logout').html_safe, logout_path)}</li>
                </ul>
                <ul>
                  <li>#{link_to(t('lines.buttons.formating_help').html_safe, "#", class: "btn-cheatsheet")}</li>
                </ul>
              </div>
            </div>".html_safe
          else
            content_tag(:span, link_to('', lines.root_path), class: 'backlink') + content_tag(:span, action_link, class: 'actionlink')
          end
        end
      end
      html    
    end

    # Returns site name for actionbar, dependend on current site
    def get_action_link
      if controller_path == 'admin/articles'
        case action_name
          when 'index' then t('lines/buttons/all_articles').html_safe
          when 'new' then t('lines/buttons/new_article').html_safe
          when 'edit' then t('lines/buttons/edit_article').html_safe
          when 'show' then t('lines/buttons/preview').html_safe
        end
      elsif controller_path == 'admin/authors'
        case action_name
          when 'index' then t('lines/buttons/all_authors').html_safe
          when 'new' then t('lines/buttons/new_author').html_safe
          when 'edit' then t('lines/buttons/edit_author').html_safe
          when 'show' then t('lines/buttons/author').html_safe
        end
      end
    end

    # Returns HTML for code blocks formatted with Pygment
    def format_code(text)
      simple_format( truncate( Sanitize.clean(markdown(text)).html_safe, escape: false, length: 300, separator: ' ', omission: ' …' ))
    end

  end
end
