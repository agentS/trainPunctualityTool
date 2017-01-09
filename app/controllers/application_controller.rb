class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index()
    if actual_user() != nil
      redirect_to(dashboard_index_path())
    else
      redirect_to(log_in_path())
    end
  end

  helper_method(:actual_user)
  private def actual_user()
    @actual_user ||= User.find(get_user_id()) if get_user_id()
  end

  private def get_user_id()
    return session[:user_id]
  end
end
