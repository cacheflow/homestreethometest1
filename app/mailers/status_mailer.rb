class StatusMailer < ActionMailer::Base
  default from: "homestreethomemail@gmail.com"

  def welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: "Thanks for signing up!")
  end

  def status_email(user)
  	@email = user
  	mail(to: @email.email, subject: "You've given me hope!!! Now Icanhas Cheezburger?")
  end
end


