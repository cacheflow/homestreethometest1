class TwilioController < ApplicationController

  # require 'rubygems' # not necessary with ruby 1.9 but included for completeness 
  # require 'twilio-ruby' 
  def index
      number_to_send_to = params[:number_to_send_to] 
    # put your own credentials here 
    # account_sid = ENV["TWILIO_ID"]
    @account_sid = Figaro.env.twilio_id 
    @auth_token = Figaro.env.twilio_secret
     
    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new @account_sid, @auth_token 
     
    @client.account.messages.create({
      :from => '+16513199035', 
      :to => '6518943894',
      :body => 'New Sad making things happen!'
      })
  end
end

