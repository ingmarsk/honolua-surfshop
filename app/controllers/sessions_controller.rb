class SessionsController < ApplicationController

	# Whitelisting: mark following method as NOT required before actions for this controller
	skip_before_action :authorize
	
  # Returns the new/view displaying the login page
  def new
  end

  # Store User ID in the session (Login)
  def create
    binding.pry
    # Grab the data submited from the new/_form sent inside the params hash.
    # Parameters: {..., "session"=>{"email"=>"...", "password"=>"..."}, ...}

    @user = User.find_by_email(params[:session][:email])

    # Authenticate(form_password) hashes the password sent from the form and matches it against the hashed
    # password_digest stored in the db for this user. Returns the #<User> object if password matches or false.
    if @user && @user.authenticate(params[:session][:password])

      # If user athenticated, its id is stored in the session so now he's logged in
      session[:user_id] = @user.id
      redirect_to store_url
    else
      redirect_to login_url, alert: "Invalid credentials, please try again."      
    end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to store_url, notice: "Logged out"
  end
end
