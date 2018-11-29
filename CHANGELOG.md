# Changelog

## 1.2.6.1
- Typo inside div tag corrected

## 1.2.6
- Security updates for the following Gems: ffi, nokogiri, rack, rails-html-sanitizer, loofah, yard

## 1.2.5
- Allow ERB syntax in `lines_config.yml`

## 1.2.4
- Can specify carrierwave storage in `lines_config.yml`
- Fixed namespacing bugs

## 1.2.3
- fix No such middleware to insert before: ActionDispatch::Static (Thanks to @scottbarrow)

##  1.2.2
- Fix JqueryUI datepicker (Thanks to @edgarlepe)

## 1.2.1.1
- Fix activerecord.errors.models translations being truncated by gem.

## 1.2.1

- Fixed compatibility with Rails 5

## 1.2 

- Added support for Rails 5

## 1.1.5, 1.1.5.1 - 1.1.5.3

- Gem updates

## 1.1.4

- Gem dependencies upated: carrierwave

## 1.1.3

- Gem dependencies updated
- Precompile rules for assets added

## 1.1.2

- typo fixes and pull request merges
- Gem dependencies updated

## 1.1.1

- Gem dependencies updated.

## 1.1.0

- 118n support now available. Locale files can be found at */config/locales/*

## 1.0.0

- Proud to announce the first stable release with the new backend!
- New README
- Minor fixes since v0.9.0
- Have fun ;)

## 0.9.0

- New backend: the entire backend has been restyled and made responsive
- New default hero images! NOTE: The old default images have been removed ("001_dark.jpg", "001.jpg", "002_dark.jpg", "002.jpg", "003_dark.jpg", "003.jpg"). If you want to further use them, just copy them over to your *public/hero*directory and add them to the *config/lines_config.yml*
- New config variable *blog_name*. NOTE: Adjust your current *lines_config.yml* and add the *blog_name* option.
- *article#show* action now list 2 related articles at the bottom
- Lots of style adjustments
- Lots of bug fixes

## 0.6.1, 0.6.2

- updated dependend gems


## 0.6

- Users are now able to reset their passwords. 
- Default styles updated. If you want to use the new version, you have to overwrite your existing lines css files.
- new generator +rails g lines:copy_styles+ added to update stylesheets from newer gem versions
- IMPORTANT: please adjust your +config/lines_config.yml+ and add +from_email+ according to the following example:
    ```
    development:
      host: "localhost:3000"
      from_email: 'noreply@example.com'
    test:
      host: "test.local"
      from_email: 'noreply@example.com'
    production:
      host: "blog.opoloo.com"
      from_email: 'noreply@example.com'
    ```
- updated required gems (actionpack and redcarpet security alerts)

## 0.5

- Completely moved from sprockets to SASS @import statements. Be aware that you have to remove all "*= require" statements from your CSS manifest and use @import instead. For more information, see: http://guides.rubyonrails.org/asset_pipeline.html
- Require statements from css manifest files removed that prevented @import statements to work correctly
- renamed .css.scss files to .scss due to Rails deprecation warning


## 0.4.6.x

- Fixed caching bug.
- Fixed issue #2 (missing brypt-ruby dependency)
- Updated rmagick gem

## 0.4.5

- BUGFIX: stylesheet for pagination is now included correctly

## 0.4.2 - 0.4.4

- upgraded gem versions and dependencies
- mior fixe

## 0.4.1

- Meta Tags and OpenGraph Tags fixed

## 0.4

- CSS finetuning. CSS files are now splitted into semantic parts.


## 0.3.3 / 0.3.3.1

- Override file for custom CSS added (lines_overrides.css.scss)
- Rendering of teaser extracted to helper method 'render_teaser'

## 0.3.2

- Pagination (kaminari gem) fixed: templates are now loaded from app/views/kaminari/lines/ as theme
- Install generator: paginator templates from kaminari gem are now correctly added to host app


## 0.3.1

- Fonts are now referenced by unified names and font attributes ('Ubuntu' instead of 'UbuntuBold' and 'UbuntuItalic')


## 0.3 

- Heavily simplified CSS and markup for articles


## 0.2

- Teaser is back!
- Various small bug fixes

## 0.1.11 / 0.1.12

- Version badge added to README
- Cleaned up gemspec


## 0.1.9 / 0.1.10 - 2014-07-10

- Obsolete files removed to reduce gem's filesize


## 0.1.8 - 2014-07-09

- Layout file for preview will now be copied from install_generator


## 0.1.7 - 2014-07-07

- [fix] seeds.rb entries corrected
- CHANGELOG.md added
