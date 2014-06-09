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
      # UserMailer.send_status_email(@donor, @status, @resident)
      text_updates(@status.content, @donor)
      twitter_update(@resident.name, @status.content)
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
    # @account_sid = ENV["TWILIO_ID"]
    # @auth_token = ENV["TWILIO_SECRET"]
    @donors = donors
    @donors.each do |d|
      if d.phone_updates
        # set up a client to talk to the Twilio REST API 
        @client = Twilio::REST::Client.new ENV["TWILIO_ID"], ENV["TWILIO_SECRET"]  
        @client.account.messages.create({
          :from => ENV["TWILIO_PHONE"], 
          :to => "#{d.phone}",
          :body => "Message: #{@content}"
          })
      end
    end
  end

  def twitter_update(name, tweet)
    @name = name
    @tweet = tweet
    consumer_key = OAuth::Consumer.new(ENV["TWITTER_CONSUMER_KEY"],
      ENV["TWITTER_CONSUMER_SECRET"])
    access_token = OAuth::Token.new(ENV["TWITTER_ACCESS_TOKEN"],
      ENV["TWITTER_ACCESS_SECRET"])

    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/update.json"
    address = URI("#{baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "status" => "#{@name.titleize}: #{@tweet}",
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
