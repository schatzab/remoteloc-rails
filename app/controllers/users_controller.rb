class UsersController < ApplicationController

  layout 'sap'

  before_action :confirm_logged_in, :except => [:new, :create]
  # we run confirm_logged_in before all actions except for our login/logout actions.  (see private in application_controller.rb)
  before_action :confirm_admin
  # confirmed admin before giving access

  def index
    @users = User.sorted # on the index we'll show a list of the admin users and it will be sorted (see our method for sorted)
  end

  def new
    @user = User.new # allows us to have a new object on the page.
  end

  def create
    # create a new admin user
    @user = User.new(user_params) # give safe parameters 
    if @user.save # if were able to save, then follow these steps:
      flash[:notice] = 'User created.'
      # redirect new user:      
      redirect_to(:action => 'index')
    else
      render("new") # show the page new.html.erb
    end
  end

  def edit
    # all we need to do is find the user here
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # find the user and if we can update it, then redirect accordingly
    if @user.update_attributes(user_params)
      flash[:notice] = 'User updated.'
      redirect_to(:action => 'index')
    else
      render("edit")
    end
  end

  def delete
    # just like edit all we're doing is finding the user
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy # find and destroy all in one step, give flash then redirect
    flash[:notice] = "The user had been deleted."
    redirect_to(:action => 'index')
  end

  private # private will not be included as one of our actions but can be referenced above as white listed insertions into the database.  Will need to be updates if I want different values in my forms.
   
    def user_params 
      params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
    end
end
 