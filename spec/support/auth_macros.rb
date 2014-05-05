module AuthMacros
  def log_in(attributes = {})
    @_current_user = FactoryGirl.create(:user, attributes)
    visit login_path
    fill_in "Email", with: @_current_user.email
    fill_in "Password", with: @_current_user.password
    click_button "Login"
    page.should have_content "Logged in"
  end

  def authorize(attributes = {})
    @current_user = FactoryGirl.create(:user, attributes)
    controller.stub(:current_user).and_return(@current_user)
    controller.stub(:authorize).and_return(true)
  end

  def current_user
    @current_user
  end
end