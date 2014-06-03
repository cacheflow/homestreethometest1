class DonationsController < ApplicationController

  def new
  	@resident = Resident.find(params[:resident_id])
  	@donation = Donation.new
  end

  def create
  	@resident = Resident.find(params[:resident_id])
    @donation = Donation.new(donation_params)
    if @donation.save
      redirect_to residents_path
    else
      render 'new'
    end
  end

  def show
    @resident = Resident.find(params[:resident_id])
    @donation = Post.find(params[:id])
  end

  def donation_params
  	params.require(:donation).permit(:amount, :donor_id, :resident_id)
  end

  
end
