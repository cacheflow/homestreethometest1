class EmailsController < ApplicationController
	def new
		@email = Email.new
	end

	def create
		@email = Email.new(params.require(:email).permit(:name, :addresss))
		if @email.save
			UserMailer.welcome(@email).deliver
			redirect_to :back
		end
	end

end
