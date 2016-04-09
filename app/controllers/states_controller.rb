 class StatesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  # confirmed logged in before giving access
  before_action :confirm_admin
  # confirmed admin before giving access

  def index
    @states = State.sorted # sorted defined in model, creating instance variable @states
  end

  def show
    @state = State.find(params[:id])
  end

  def new
    @state_count = State.count + 1
    @state = State.new({:name => "Default"})
  end

  def create
    @state = State.new(state_params)
    # instantiate a new object using parameters
    if @state.save # if saved, redirect to index
      flash[:notice] = "State created successfully."
      redirect_to(:action => 'index')
    else # if not saved, show form again
      @state_count = State.count + 1
      render('new')
    end
  end

  def edit 
    # first find object to edit
    @state = State.find(params[:id])
    @state_count = State.count
  end

  def update
    # Find an exisiting object using form parameters
    @state = State.find(params[:id])
    #update the object
    if @state.update_attributes(state_params) #the update is mass assigning so we use the same subject_params from below to safely insert into the database. if update succeeds
      flash[:notice] = "State updated successfully."
      redirect_to(:action => 'show', :id => @state.id)
    # Third, redirect to a page (such as index)
    else
      @state_count = State.count
      # -if- update fails, redisplay the form
      render('edit') # show the edit form.
    end
  end

  def delete
    @state = State.find(params[:id])
  end

  def destroy
    state = State.find(params[:id]).destroy #don't need instance variable here as we'll never display a destroy.html.erb page which might need the instance variable
    flash[:notice] = "The state #{state.name} was deleted successfully."
    redirect_to(:action => 'index')
  end

  private

  def state_params
      params.require(:state).permit(:name, :position, :visible, :created_at)
  end
end
