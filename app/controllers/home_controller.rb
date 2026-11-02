class HomeController < ApplicationController
  before_action :require_login

  def index
  end

  private

  def require_login
    unless session[:username]
      redirect_to login_path, alert: "Please log in first."
    end
  end
end
