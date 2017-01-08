require 'test_helper'

class UserTest < ActiveSupport::TestCase
	DEMO_USERNAME = "Lukas"
	DEMO_PASSWORD = "Cisco0"

	test "create a user" do
		demo_user = create_user(DEMO_USERNAME, DEMO_PASSWORD)

		assert(demo_user.save(), "Could not create a user.")
	end

	test "authenticate user" do
		demo_user = create_user(DEMO_USERNAME, DEMO_PASSWORD)
		demo_user.save()

		assert_not_nil(User.authenticate(DEMO_USERNAME, DEMO_PASSWORD), "Authentication failed")
	end

	private def create_user(username, password)
		user = User.new()
		user.username = username
		user.password = password

		return user
	end
end
