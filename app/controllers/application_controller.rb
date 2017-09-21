class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Makes current_user method available in the views
  helper_method :current_user
  helper_method :require_buyer
  helper_method :require_seller
  helper_method :require_admin

  # Determines whether a user is logged in or logged out.
  # Checks whether there's a user in the database with a given session id. 
  # If there is, this means the user is logged in and @current_user will store that user,
  # otherwise the user is logged out and @current_user will be nil
  def current_user
    # a ? a : a = b
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Redirect logged out users to the login page
  def require_user
    redirect_to login_url unless current_user
  end

  def require_buyer
    redirect_to store_url if !current_user || !current_user.buyer?  
  end

  def require_seller
    redirect_to store_url if !current_user || !current_user.seller?
  end

  def require_admin
    redirect_to store_url if !current_user || !current_user.admin?
  end

  # Prevents methods below of being exposed to end users as an action
  protected
	
end
