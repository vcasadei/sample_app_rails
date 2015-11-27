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
    
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
    assert_select 'li', "Name can't be blank"
    assert_select 'li', "Email is invalid"
    assert_select 'li', "Password confirmation doesn't match Password"
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
    
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
    assert_select 'li', "Email is invalid"
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
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
    assert_select 'li', "Password confirmation doesn't match Password"
  end
  
  test "valid signup information - sucess" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
    assert_select 'div.alert-success'
    assert_not flash.nil?
  end
end
