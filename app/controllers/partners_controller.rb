class PartnersController < ApplicationController
  load_and_authorize_resource

  respond_to :json, :html

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      respond_to do |format|
        format.html {UserMailer.welcome_email(@partner).deliver
          redirect_to partners_path}
        format.json {render json: @partner, status: :created}
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
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
      respond_to do |format|
        format.html { redirect_to partners_path }
        format.json { render nothing: true, status: :no_content }
      end
   else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @partners = Partner.all
    respond_with @partners
  end

  def show
    @partner = Partner.find(params[:id])
    @residents = @partner.residents
    respond_with @partner
  end
  def partner_params
    params.require(:partner).permit(:name, :org, :address, :phone, :email, :website, :user_id, :resident_id)
  end
end
