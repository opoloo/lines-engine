require 'spec_helper'

feature 'user resets password' do
  before(:each) do
    @user = FactoryGirl.create(:user, password: 'password1234')
    visit lines.login_path
    expect(page).to have_content "Forgot password"
    click_on "Forgot password"
    expect(page).to have_content "Email"
    fill_in "Email", with: @user.email
    click_on 'Submit'
    expect(page).to have_content "Email sent with password reset instructions"
  end

  scenario 'with valid password' do
    
  end

  scenario 'with password too shord' do

  end

  scenario 'with password confirmation not matching' do

  end

end