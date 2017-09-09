class SessionsController < ApplicationController

	# Whitelisting: mark following method as NOT required before actions for this controller
	skip_before_action :authorize
	
  # Returns the new/view displaying the login page
  def new
  end

  # Store User ID in the session (Login)
  def create
    # Grab the data submited from the new/_form sent inside the params hash.
    # Parameters: {..., "session"=>{"email"=>"...", "password"=>"..."}, ...}

    @user = User.find_by_email(params[:session][:email])

    # Authenticate(form_password) hashes the password sent from the form and matches it against the hashed
    # password_digest stored in the db for this user. Returns the #<User> object if password matches or false.
    if @user && @user.authenticate(params[:session][:password])

      # Save the user id inside the browser cookie. 
      # This is how we keep the user logged in when they navigate around the site.
      session[:user_id] = @user.id
      
      # Also store the name for the nocie alert (not necessary)
      session[:user_first_name] = @user.first_name
      redirect_to store_url, notice: "Welcome back #{@user.first_name}!"
    else
      redirect_to login_url, alert: "Invalid credentials, please try again."      
    end
  end

  # Logout
  def destroy
    # binding.pry
    user_first_name = session[:user_first_name]
  	session[:user_id] = nil
  	redirect_to store_url, notice: "See you #{user_first_name}!"
  end
end
