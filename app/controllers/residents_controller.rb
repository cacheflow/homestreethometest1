class ResidentsController < ApplicationController
	def index
		@residents = Resident.all
	end
end
