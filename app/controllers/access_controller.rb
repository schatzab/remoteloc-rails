class AccessController < ApplicationController
 
  layout 'sap' # sets css and layout template

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout] 
    # run confirm_logged_in before all actions except for login/logout and addloc actions.  (see private in application_controller.rb)
  before_action :confirm_admin, :except => [:login, :attempt_login, :logout, :addLoc] 

  def index 
  	# display text and links
  end

  def addLoc
    # display form for adding a location
  end

  def login
  	# login form
  end

  def attempt_login
  	if params[:username].present? && params[:password].present? #First check if user is in the DB
  		found_user = User.where(:username => params[:username]).first #assign user to found user if we have it.
  		if found_user
  			authorized_user = found_user.authenticate(params[:password]) # can if be authenticated?
  		end
  	end
  	if authorized_user # if found user is true:
  		#  mark user as logged in
      session[:user_id] = authorized_user.id
      session[:admin] = authorized_user.admin # use this to test if user is an admin
      session[:username] = authorized_user.username # store these values in our session so we can grab these values rather than always going back to DB.
  		flash[:notice] = "You are now logged in."
  		redirect_to(:controller => 'public', :action => 'index')
  	else # if found user is false it will jump here:
  		flash[:notice] = "Invalid username/password combination."
  		redirect_to(:action => 'login')
  	end 
  end

  def logout
    # mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "logged out" # give notice that they're logged out and redirect them.
    redirect_to(:action => "login")
  end
end