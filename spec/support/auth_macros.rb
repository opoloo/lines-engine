module AuthMacros

  def log_in(attributes = {})
    @_current_lines_user = FactoryGirl.create(:user, attributes)
    visit lines.login_path
    fill_in "email", with: @_current_lines_user.email
    fill_in "password", with: @_current_lines_user.password
    click_button "Login"
    page.should have_content "Logged in"
  end

  def authorize(attributes = {})
    @current_lines_user = FactoryGirl.create(:user, attributes)
    controller.stub(:current_lines_user).and_return(@current_lines_user)
    controller.stub(:authorize).and_return(true)
  end

  def current_lines_user
    @current_lines_user
  end
end