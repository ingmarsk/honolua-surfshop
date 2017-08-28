class SessionsController < ApplicationController

	# Whitelisting: mark following method as NOT required before actions for this controller
	skip_before_action :authorize
	
  def new
  end

  # Store User ID in the session (Login)
  def create
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to admin_url
  	else
  		redirect_to login_url, alert: "Invalid user or password"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to store_url, notice: "Logged out"
  end
end
