class UsersController < AuthenticatedController
	def index()
		@users = User.all()
	end

	def new()
		@user = User.new()
	end

	def create()
		@user = User.new(user_parameters())

		if @user.save() == true
			redirect_to(users_url())
		else
			render("new")
		end
	end

	def edit()
		@user = User.find(params[:id])
	end

	def update()
		@user = User.find(params[:id])

		if @user.update(user_parameters()) == true
			redirect_to(users_url())
		else
			render("edit")
		end
	end

	def destroy()
		@user = User.find(params[:id])
		@user.destroy()

		redirect_to(users_path())
	end

	private def user_parameters()
		params.require(:user).permit(:username, :password, :password_confirmation)
	end
end
