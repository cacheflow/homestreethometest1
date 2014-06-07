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
      text_updates(@status.content, @donor)
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

  def text_updates(content, donors)
    @content = content
    @account_sid = Figaro.env.twilio_id 
    @auth_token = Figaro.env.twilio_secret
    @donors = donors
    @donors.each do |d|
      if d.phone_updates
        # set up a client to talk to the Twilio REST API 
        @client = Twilio::REST::Client.new @account_sid, @auth_token  
        @client.account.messages.create({
          :from => '+16513199035', 
          :to => "#{d.phone}",
          :body => "Message: #{@content}"
          })
      end
    end
  end

  def status_params
  	params.require(:status).permit(:content, :resident_id)
  end
end
