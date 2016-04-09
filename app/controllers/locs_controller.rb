class LocsController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  # confirmed logged in before giving access
  before_action :find_city
  # find the city id
  before_action :confirm_admin
  # confirmed admin before giving access

  def index # shows locations according to their cities
    @locs = Loc.where(:city_id => @city.id).sorted
  end

  def all # shows all locations
    @locs = Loc.sortedAll
  end

  def show
    @loc = Loc.find(params[:id])
  end

  def new
    @loc = Loc.new({:city_id => @city.id, :name => "New Remote Location...", :user_city => @loc.user_city})
    @cities = @city.state.cities.sorted
    @loc_count = Loc.count + 1
  end

  def create
    @locs = Loc.new(loc_params)
    if @locs.save
      flash[:notice] = "Location has been created successfully."
      redirect_to(:action => 'index', :city_id => @city.id)
    else
      @loc_count = Loc.count + 1
      @cities = City.order('position ASC')
      render('new')
    end
  end

  # Edit an approved location
  def edit
    @loc = Loc.find(params[:id])
  end

  def update
    @loc = Loc.find(params[:id])
    if @loc.update_attributes(loc_params) #the update is mass assigning so we use the same subject_params from below to safely insert into the database. if update succeeds
      flash[:notice] = "Location updated successfully."
      redirect_to(:action => 'show', :id => @loc.id, :city_id => @city.id)
    else
      @loc_count = Loc.count
      render('edit') 
    end
  end

  # Edit a pending location
  def edit_pub
    @loc = Loc.find(params[:id])
  end

  def update_pub
    @loc = Loc.find(params[:id])
    if @loc.update_attributes(loc_params) #the update is mass assigning so we use the same subject_params from below to safely insert into the database. if update succeeds
      flash[:notice] = "Location updated successfully."
      redirect_to(:action => 'all', :id => @loc.id)
    else
      @loc_count = Loc.count
      render('edit_pub') 
    end
  end

  def pending
    @loc = Loc.find(params[:id])
  end

  def delete
    @loc = Loc.find(params[:id])
  end

  def destroy
    loc = Loc.find(params[:id]).destroy
    flash[:notice] = "Location has been deleted."
    redirect_to(:action => 'index', :city_id => @city.id)
  end

  # destroy pending location
   def delete_pub
    @loc = Loc.find(params[:id])
  end

  def destroy_pub
    loc = Loc.find(params[:id]).destroy
    flash[:notice] = "Location has been deleted."
    redirect_to(:action => 'all')
  end

  private

  def loc_params
      params.require(:loc).permit(:city_id, :name, :phone, :address, :website, :position, :visible, :content, :created_at, :user_city)
  end

  def find_city
     if params[:city_id]
      @city = City.find(params[:city_id])
     end
  end
end