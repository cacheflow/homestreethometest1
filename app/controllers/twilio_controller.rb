class TwilioController < ApplicationController

  # require 'rubygems' # not necessary with ruby 1.9 but included for completeness 
  # require 'twilio-ruby' 
  def index
      number_to_send_to = params[:number_to_send_to] 
    # put your own credentials here 
    account_sid = ENV["TWILIO_ID"] 
    auth_token = ENV["TWILIO_SECRET"]
    twilio_phone_number = '+16513199035' 
     
    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new account_sid, auth_token 
     
    @client.account.messages.create({
      :from => '+16513199035', 
      :to => #'YOUR_PHONE_NUMBER', 
      :body => 'Mr New Sad is feeling better today:  Dear donor, I want to thank you for your ongoing support. I was able to buy a few clothing items at Abercrombie & Fitch today thanks to people like you. As everybody knows, it is our, we homefulers, favorite place to shop. I also met the most amazing kitten today. I named him Philip Semore Hoffman, in honor of the late Santa Monican scuba instructor. Anyway, Im going to get wasted on hopes and dreams! Thanks again. (and yes, i am an out of work English teacher if you were wondering why my grammar is very good)'  
    })
  end
end

