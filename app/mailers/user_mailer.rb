class UserMailer < ActionMailer::Base
  default from: "merlin@homestreethome.com"

  def welcome_email(user)
  	@email = user
  	@url = 'http://icanhas.cheezburger.com/lolcats'
  	mail(to: @email.email, subject: "Thank you for being a part of HomeStreetHome")
  end
end
