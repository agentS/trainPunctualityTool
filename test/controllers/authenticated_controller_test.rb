require "test_helper"

class AuthenticatedControllerTest < ActionDispatch::IntegrationTest
	LOGIN_USERNAME = "lukas"
	LOGIN_PASSWORD = "Cisco0"

	setup do
		authenticate()
	end

	def authenticate()
		tested_controller = @controller
		@controller = SessionsController.new()

		post(sessions_path(), params: {
			username: LOGIN_USERNAME,
			password: LOGIN_PASSWORD
		})
		session_cookie = @response.cookies["_trainPunctualityTool_session"]
		puts(session_cookie)

		@controller = tested_controller

		@request.cookies["_trainPunctualityTool_session"] = session_cookie
	end
end