module ApplicationHelper

	class Twilio_texts
		def text_updates()
		      # number_to_send_to = params[:number_to_send_to] 
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
end
