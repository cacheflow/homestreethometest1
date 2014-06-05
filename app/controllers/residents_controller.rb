class ResidentsController < ApplicationController
  load_and_authorize_resource
  respond_to :json, :html
  def new
    @resident = Resident.new
  end

  def create
    @resident = Resident.new(resident_params)
    if @resident.save 
      respond_to do |format|
        format.html {redirect_to residents_path}
        format.json {render json: @resident, status: :created}
      end 
    else 
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @resident = Resident.find(params[:id])
  end

  def update
    @resident = Resident.find(params[:id])
    if @resident.update(resident_params)
      respond_to do |format|
        format.html { redirect_to residents_path }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @resident = Resident.find(params[:id])
    respond_with @resident
  end

  def index
    @residents = Resident.all
    respond_with @residents
  end

 
  def resident_params
    params.require(:resident).permit(:name, :bio, :goals, :partner_id, :picture, :user_id, :goal_monetary)
  end
end
