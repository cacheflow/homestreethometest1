class StatusesController < ApplicationController
  require 'oauth'

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
      twitter_update
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

  def twitter_update
    puts "is this working"
    consumer_key = OAuth::Consumer.new(
      "JGAZVgMigbhmp1WJ7Tj8e2ZRk",
      "hNq06ljAW8TsZ8wudIVpbQOo3OY8mJjgQH8giVPuQfcXJRS4WG")
    access_token = OAuth::Token.new(
      "2551746222-GxYCa53zecd2Pgg54ZYiTG2WmCGGZ6vSuMHP7G5",
      "T7XHLnP4I1NsxJY2bqjOLle5byWztBjBPvIzvFHHsPEML")

    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/update.json"
    address = URI("#{baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "status" => "HomeStreetHome will be debuting its live application on Monday! Wish us luck!",
    )

    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    tweet = nil
    if response.code == '200' then
      tweet = JSON.parse(response.body)
      puts "Successfully sent #{tweet["text"]}"
    else
      puts "Could not send the Tweet! " +
      "Code:#{response.code} Body:#{response.body}"
    end
  end

  def status_params
  	params.require(:status).permit(:content, :resident_id)
  end
end
