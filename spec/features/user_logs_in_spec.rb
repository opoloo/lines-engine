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
    fill_in "password", with: 'sekret1234'
    click_button "Login"
    page.should have_content('Email or password is invalid')
  end

  scenario 'with blank password' do
    @_current_lines_user = FactoryGirl.create(:user, email: 'valid@example.com')
    visit lines.login_path
    fill_in "email", with: "valid@example.com"
    fill_in "password", with: ''
    click_button "Login"
    page.should have_content('Email or password is invalid')
  end 

end