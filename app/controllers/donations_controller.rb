class DonationsController < ApplicationController

  def index
  	@donations = Donation.all
  end
  def new
  	@donation = Donation.new
  end
  def create
    @donation = Donation.new(donation_params)
    if @donation.save
      redirect_to donations_path
    else
      render 'new'
    end
  end
  def donation_params
  	params.require(:donation).permit(:amount, :donor_id, :resident_id)
  end
end
