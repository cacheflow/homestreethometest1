class StatusesController < ApplicationController
  def index
  	@resident = Resident.find(params[:resident_id])
	@statuses = Status.all
  end
  def new
  	@resident = Resident.find(params[:resident_id])
  	@status = Status.new
  end

  def create
  	@resident = Resident.find(params[:resident_id])
  	@donor = @resident.donors
    @status = Status.new(status_params)
    if @status.save
      UserMailer.send_status_email(@donor, @status, @resident)
      redirect_to residents_path
    else
      render 'new'
    end
  end

  def show
    @resident = Resident.find(params[:resident_id])
    @status = Status.find(params[:id])
  end

  def edit
  	@resident = Resident.find(params[:resident_id])
    @status = Status.find(params[:id])
  end

  def update
  	@resident = Resident.find(params[:resident_id])
    @status = Status.find(params[:id])
	if @status.update(status_params)
      redirect_to resident_status_path(@resident, @status)
    else
      render 'edit'
    end
  end

  def status_params
  	params.require(:status).permit(:content, :resident_id)
  end
end
