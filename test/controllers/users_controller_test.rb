class UsersControllerTest < AuthenticatedControllerTest
  DEMO_USER_NAME = "Lukas"
  DEMO_USER_PASSWORD = "Cisco0"

  test "create new user" do
    assert_difference("User.count") do
      post(users_url(), params: {
        user: {
          username: DEMO_USER_NAME,
          password: DEMO_USER_PASSWORD,
          password_confirmation: DEMO_USER_PASSWORD
        }
      })
    end
  end
end
