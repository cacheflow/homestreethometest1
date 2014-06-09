class UserMailer < ActionMailer::Base
  default from: "homestreethomemail@gmail.com"

  def welcome_email(user)
  	@email = user
  	@url = 'http://icanhas.cheezburger.com/lolcats'
  	mail(to: @email.email, subject: "Thank you for being a part of HomeStreetHome")
  end

  def status_email(u, status, resident)
  	@u = u
  	@status = status
  	@resident = resident
  	mail(to: @u.email, subject: "Thanks, #{@u.name}!!!")
  	end

  	def self.send_status_email(user, status, resident)
  		@users = user
  		@users.each do |u|
  			if u.email_updates
  			  status_email(u, status, resident).deliver
  			end
  		end
  	end
  	
end
