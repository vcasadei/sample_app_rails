require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end
  
  test "invalid signup information - email" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "User New",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "foo" }
    end
    assert_template 'users/new'
  end
  
  test "invalid signup information - password" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "User New",
                               email: "user@valid.com",
                               password:              "foo",
                               password_confirmation: "" }
    end
    assert_template 'users/new'
  end
end
