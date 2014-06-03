class StatusMailer < ActionMailer::Base
  default from: "homestreethomemail@gmail.com"

  def welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: "Thanks for signing up!")
  end
end
