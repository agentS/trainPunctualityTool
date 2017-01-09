class AuthenticatedController < ApplicationController
  before_action(:require_login)

  private def require_login()
    if self.actual_user() == nil
      redirect_to(log_in_path())
    end
  end

  def actual_user()
    actual_user ||= User.find(get_user_id()) if get_user_id()
    return actual_user
  end

  def get_user_id()
    return session[:user_id]
  end
end