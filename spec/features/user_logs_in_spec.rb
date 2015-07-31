require 'spec_helper'

feature 'user logs in' do
  scenario 'with valid email and password' do
    log_in({ email: 'valid@example.com', password: 'password' })

    expect(page).to have_content('Logged in')
  end

  scenario 'with invalid email' do
    @_current_lines_user = FactoryGirl.create(:user)
    visit lines.login_path
    fill_in "email", with: "invalid_email"
    fill_in "password", with: 'sekret'
    click_button "Login"
    page.should_not have_content "Logged in"
    page.should have_content('Login')
  end

  scenario 'with blank password' do
    @_current_lines_user = FactoryGirl.create(:user, email: 'valid@example.com')
    visit lines.login_path
    fill_in "email", with: "valid@example.com"
    fill_in "password", with: ''
    click_button "Login"
    page.should_not have_content "Logged in"
    page.should have_content('Login')
  end 

end