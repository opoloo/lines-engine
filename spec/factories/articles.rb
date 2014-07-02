require 'faker'

FactoryGirl.define do
  factory :article, :class => Lines::Article do |f|
    f.title "Testing with RSpec"
    f.sub_title "My subtitle"
    f.content "Content for article"
    f.published_at Time.now
    f.hero_image { File.open(File.join(Lines::Engine.root, 'spec/support/images/example.jpg')) }
    f.author_ids   {
      count = 0
      Array(5..10).sample.times.map do
        count += 1
        FactoryGirl.create(:author, :name => "Author #{count}", :email => "author#{count}@example.com", :description => "desc#{count}")[:id]
      end
    }

    factory :article_with_tags, class: Lines::Article do |a|
      a.tag_list 'tag1, tag2'
    end
  end
end