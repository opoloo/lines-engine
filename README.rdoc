{<img src="http://lines.opoloo.com/assets/images/screenshots/git-logo.png" />}[http://lines.opoloo.com/assets/images/screenshots/git-logo.png]

= LINES Publishing Engine by Opoloo[https://www.opoloo.com]

{<img src="https://badge.fury.io/rb/lines-engine.svg" alt="Gem Version" />}[http://badge.fury.io/rb/lines-engine]


== Introduction

LINES is a customizable publishing framework for Rails developers. It makes your publications and the processes around it simple and beautiful.

LINES is designed for mobile publishing needs. You work in a clear, responsive backend where you write with a distraction-free markdown editor, and where publishing your articles is dead simple. Readers enjoy your writing, not least because it’s perfectly readable on all screens.

LINES is a framework for tech-savvies who care about writing and publishing, with the freedom of full OSS access.

Learn more at the {Lines Website}[http://lines.opoloo.com], or see it in action: https://www.opoloo.com/blog.


== Purpose, Features, Specifications

LINES is designed for
- distraction-free writing and editing
- a simple, consistent, mobile publishing process
- clear, responsive presentation
- customization
- full focus on content


=== Features
- authentication system (with password reset, remember token, …)
- custom hero graphics for posts
- upload default hero images that you want to re-use
- customizable generic titles & subtitles
- automatic teaser & scaled image for the article overview
- determine featured article
- GitHub Flavored Markdown (four headline styles according to priority, italics & bold text, block quotes and citation, images, lists, links, image captions, …)
- code syntax highlighting
- formatting help
- tags for articles
- G+ link to social network discussion
- multiple authors and author information (for your small company or guest authors)
- add documents for download
- direct RSS reader access


== Installation

1. Add the gem to your Gemfile:
    gem 'lines-engine'

2. Run 'bundle':
    bundle

3. There is an installation task that will guide you through the rest of the installation process. Just switch to your application directory and run:
    rails g lines:install

4. Adjust settings for Lines in the newly generated <tt>config/lines_config.yml</tt> file.

5. Run database migrations:
    rake db:migrate

If you need some more information or help, you can just follow this read me file.


=== Managing admin users

Currently, LINES does not offer a GUI for managing users, but you can use a rake task to do so:

  rake lines:add_user

To update an existing user, you’ll need the rails console with 'rails c'


=== UPDATE an existing user
  u = Lines::User.find_by(email: 'your@email.com')
  u.email = "new@mail.com"
  u.password = "newsekret"
  u.save


=== Google Sitemap

The sitemap_generator gem (https://github.com/kjvarga/sitemap_generator) handles the creation of site maps for search engines. To update the sitemap on server, run:

  bundle exec rake sitemap:refresh:no_ping # don’t ping search engines
  bundle exec rake sitemap:refresh         # ping search engines

Don’t forget to adjust the full URL to your sitemaps in <tt>public/robots.txt</tt>


== Documentation

The complete documentation can be found at RubyDoc.info: http://www.rubydoc.info/gems/lines-engine/


== Customization


=== Copy/update stylesheets

Run <tt>rails g lines:copy_styles</tt> to install stylesheets from newer gem versions. Keep in mind to backup your overrides and other customizations before doing so!


=== Modify CSS/SCSS

Find the SASS files inside the <tt>app/assets/stylesheets/lines/</tt> directory.

Use the <tt>app/assets/stylesheets/lines/lines_overrides.scss</tt> file to adjust existing styles or add new ones.

=== Modify custom hero images

You can change, remove, or add the +HERO_IMAGES+ variable inside the <tt>config/lines_config.yml</tt> file. The corresponding images reside inside the <tt>public/heroes</tt> directory.


=== Header (Meta) & Footer

To change the header/meta/footer elements you need to modify <tt>app/views/layouts/lines/application.html.erb</tt> and the corresponding partials.


== Screenshots

=== Dashboard
{<img src="http://lines.opoloo.com/assets/images/screenshots/git-dashboard.png" />}[http://lines.opoloo.com/assets/images/screenshots/git-dashboard.png]

=== Create or edit an article

{<img src="http://lines.opoloo.com/assets/images/screenshots/git-editor.png" />}[http://lines.opoloo.com/assets/images/screenshots/git-editor.png]

=== Preview

{<img src="http://lines.opoloo.com/assets/images/screenshots/git-post.png" />}[http://lines.opoloo.com/assets/images/screenshots/git-post.png]

=== Articles overview

{<img src="http://lines.opoloo.com/assets/images/screenshots/git-overview.png" />}[http://lines.opoloo.com/assets/images/screenshots/git-overview.png]


== Contributors
A big thanks goes to these wonderful people for their contributions and support:

@MyXoToD, @adonespitogo, @scottbarrow, @aziflaj, @dafuga, @usamah82, @edgarlepe


== License

You may use the Lines blog template as you please. You’d make us happy, though, if you kept an attribution to {Lines}[http://lines.opoloo.com/] and {Opoloo}[https://www.opoloo.com] to spread the word.

We heartily invite you to extend the features of the engine, but when you do, you should fork it on GitHub, so everyone can profit from your work.

You can see the full license here: http://choosealicense.com/licenses/lgpl-v3/
