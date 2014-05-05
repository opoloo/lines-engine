require 'spec_helper'

def login_and_visit_new_article
  log_in({ email: 'valid@example.com', password: 'password123' })
  expect(page).to have_content('Logged in')
  @author = FactoryGirl.create(:author, name: "Foo Bar")
  visit admin_articles_path
  click_on "New Article"
  expect(page).to have_content('New article')
end

def create_valid_article
  expect(page).to have_content('New article')
  fill_in "Title", with: "How to Test"
  fill_in "Content", with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  check "Foo Bar"
  fill_in "Subtitle", with: "with RSpec and Rails"
  fill_in "G+ URL", with: "http://gplus.de/opoloo"
  attach_file('article_hero_image', File.join(Rails.root, '/spec/support/images/example.jpg'))
  click_on "Save"
  expect(page).to have_content "How to Test"
end

feature 'user creates article' do
  before(:each) do
    login_and_visit_new_article
  end

  scenario 'with valid valid attributes' do
    create_valid_article
    current_path.should == "/admin/articles/how-to-test"
    expect(page).to have_content "How to Test"
    expect(page).to have_content "Lorem ipsum dolor"
    expect(page).to have_content "Foo Bar"
    expect(page).to have_content "RSpec and Rails"
  end

  scenario 'with invalid attributes' do
    click_on "Save"
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Content can't be blank"
    expect(page).to have_content "Author ids can't be blank"
    expect(page).to have_content "You have to either select an image or upload one."
  end

end

feature 'user publishes an article' do
  before(:each) do
    login_and_visit_new_article
  end
  scenario 'with article is unpublished' do
    create_valid_article
    click_on "Publish"
    page.find("table.published").should have_content "How to Test"
  end

end