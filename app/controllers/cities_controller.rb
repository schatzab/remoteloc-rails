 class CitiesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  # confirmed logged in before giving access
  before_action :find_state
  # make sure all city pages have access to their state's ID
  before_action :confirm_admin
  # confirmed admin before giving access
   
  def index
    @cities = City.where(:state_id => @state.id).sorted 
    # @cities = @state.cities.sorted
  end

  def show
    @city = City.find(params[:id])
  end

  def new
    @city = City.new({:state_id => @state.id, :name => "New City..."}) ##### :state_id => @state.name
    @states = State.order('position ASC')
    @city_count = City.count + 1
  end

  def create
    @city = City.new(city_params)
    if @city.save
      flash[:notice] = "City has been created successfully."
      redirect_to(:action => 'index', :state_id => @state.id)
    else
      render('new')
    end
  end  

  def edit
     @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    if @city.update_attributes(city_params) #the update is mass assigning so we use the same subject_params from below to safely insert into the database. if update succeeds
      flash[:notice] = "City updated successfully."
      redirect_to(:action => 'show', :id => @city.id, :state_id => @state.id)
    else
      @city_count = City.count
      render('edit') 
    end
  end

  def delete
     @city = City.find(params[:id])
  end

  def destroy
    city = City.find(params[:id]).destroy
    flash[:notice] = "City has been deleted."
    redirect_to(:action => 'index', :state_id => @state.id)
  end

  private

  def city_params
      params.require(:city).permit(:state_id, :name, :permalink, :position, :visible, :created_at)
  end

  def find_state
     if params[:state_id]
      @state = State.find(params[:state_id])
     end
  end
end
