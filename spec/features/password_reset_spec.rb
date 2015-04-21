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
    #generate new reset token
    @user.create_reset_digest
    visit lines.edit_password_reset_url(@user.reload.reset_token, email: @user.email)
    expect(page).to have_content 'Password Confirmation'
  end

  scenario 'with valid password' do
    fill_in "Password", with: 'testtest'
    fill_in "Confirmation", with: 'testtest'
    click_on 'Update password'
    expect(page).to have_content 'Password has been reset.'
    expect(@user.reload.reset_digest).to eq nil
  end

  scenario 'with password too short' do
    fill_in "Password", with: 't'
    fill_in "Confirmation", with: 't'
    click_on 'Update password'
    expect(page).to have_content 'too short'
  end

  scenario 'with empty password' do
    fill_in "Password", with: ''
    fill_in "Confirmation", with: ''
    click_on 'Update password'
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'with password confirmation not matching' do
    fill_in "Password", with: 'testtest'
    fill_in "Confirmation", with: 'testtest234'
    click_on 'Update password'
    expect(page).to have_content 'not match'
  end

end