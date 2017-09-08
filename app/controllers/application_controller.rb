class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Invoke authorize() before every action in whole the app
  # before_action :authorize

  # Prevents methods below of being exposed to end users as an action
  protected

	# If user has no session (its not an admin) redirec to login
  def authorize
  	unless User.find_by(id: session[:user_id])				
  		redirect_to login_url, notice: "Please log in"
  	end
  end
end
