class SessionsController < ApplicationController
  def new()
  end

  def create()
    user = User.authenticate(params[:username], params[:password])

    if user != nil
      save_user_id(user.id)
      redirect_to(dashboard_index_path())
    else
      flash.now.alert=("Invalid username or password!")
      render("new")
    end
  end

  private def save_user_id(user_identifier)
    session[:user_id] = user_identifier
  end

  def destroy()
    drop_user_id()
    redirect_to(root_url())
  end

  private def drop_user_id()
    session[:user_id] = nil
  end
end
