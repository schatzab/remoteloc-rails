class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # check to see if the user is an admin, available to all controllers
  #def is_admin
      #return true if self.admin == 1 #The admin account type
  #end

  # This confirm_logged_in action is now available to all controllers
  def confirm_logged_in
    unless session[:user_id] 
      # If there is no user_id then do this:
      flash[:notice] = "Please log in."
      redirect_to(controller: 'access', action: 'login') # make sure to add in which controller holds the action "login" so the other controllers know where to find it.
      return false 
      # *** halts the before_action IMPORTANT!
    else
      return true # allows the before_action to continue
    end
  end

   # The user must be an admin to access these areas
  def confirm_admin
    unless session[:admin] 
      # If is not admin then do this:
      flash[:notice] = "You do not have sufficient access to visit this page."
      redirect_to(controller: 'public', action: 'index') 
      return false 
      # *** halts the before_action IMPORTANT!
    else
      return true # allows the before_action to continue
    end
  end
end