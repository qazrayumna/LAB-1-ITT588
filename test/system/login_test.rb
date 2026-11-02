require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  def setup
    super

    @password_file = Rails.root.join("Password.txt")
    @original_password_file = @password_file.exist? ? @password_file.binread : nil

    @password_file.write("ci_test_user,ci_test_password,student\n")
  end

  def teardown
    begin
      if @password_file
        if @original_password_file.nil?
          @password_file.delete if @password_file.exist?
        else
          @password_file.binwrite(@original_password_file)
        end
      end
    ensure
      super
    end
  end

  test "user can log in, access home page and log out" do
    # Check that users cannot access home without logging in
    visit home_path
    assert_current_path login_path
    assert_text "Please log in first."

    # Check invalid login
    fill_in "username", with: "wrong_user"
    fill_in "password", with: "wrong_password"
    click_button "Login"

    assert_text "Invalid username or password."

    # Check successful login
    fill_in "username", with: "ci_test_user"
    fill_in "password", with: "ci_test_password"
    click_button "Login"

    assert_text "LOGIN SUCCESSFUL!"
    assert_text "Welcome, ci_test_user"
    assert_text "Your role is: Student"

    # Check logout
    click_button "Logout"

    assert_current_path login_path
    assert_text "Successfully logged out!"
  end
end
