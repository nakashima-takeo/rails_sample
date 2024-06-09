require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar"
                                       }
                               }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    # 警告メッセージが含まれるdivが存在することを確認
    assert_select 'div.alert.alert-danger', text: /The form contains/
    # エラーメッセージのリストが存在することを確認
    assert_select 'ul' do
      assert_select 'li', "Name can't be blank"
      assert_select 'li', "Email is invalid"
      assert_select 'li', "Password is too short (minimum is 8 characters)"
    end
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user:{
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
