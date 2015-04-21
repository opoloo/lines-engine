# Changelog

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