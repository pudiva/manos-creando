class ApplicationController < ActionController::Base
  helper_method :logged_in?
  http_basic_authenticate_with name: ENV.fetch("USER"), password: ENV.fetch("PASS"), only: %i[ login ]

  def login
    session[:logged_in] = true
    redirect_to root_path, notice: "Logged in!!1"
  end

  def logout
    session[:logged_in] = false
    redirect_to root_path, notice: "Logged out!!1"
  end

  private

  def logged_in?
    session[:logged_in] == true
  end
end
