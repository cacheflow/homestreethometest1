class PartnersController < ApplicationController
  load_and_authorize_resource
  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      UserMailer.welcome_email(@partner).deliver
      redirect_to partners_path
    else
      render 'new'
    end
  end

  def edit
    @partner = Partner.find(params[:id])
    @residents = @partner.residents
  end

  def update
    @partner = Partner.find(params[:id])
    @residents = @partner.residents
    if @partner.update(partner_params)
      redirect_to partners_path
    else 
      render 'edit'
    end
  end

  def index
    @partners = Partner.all
  end

  def show
    @partner = Partner.find(params[:id])
    @residents = @partner.residents
  end
  def partner_params
    params.require(:partner).permit(:name, :org, :address, :phone, :email, :website, :user_id, :resident_id)
  end
end
