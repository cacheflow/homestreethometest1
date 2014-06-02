class FulfillmentsController < ApplicationController

	def index
      @fulfillments = Fulfillment.all
  	end

    def new
      @fulfillment = Fulfillment.new
    end

	def create
	  @fulfillment = Fulfillment.new(params[:fulfillment])

	  if @fulfillment.save
	    session[:fulfillment_id] = @fulfillment.id
	    redirect_to @fulfillment, notice: 'Fulfillment was successfully created.'
	  else
	    render action: "new"
	  end
	end

	def show
	  @fulfillment = Fulfillment.find(params[:id])
	  @is_admin = current_user && current_user.id == @fulfillment.id
	end

	# GET /fulfillments/new
	def new
	  if current_user
	    redirect_to root_path, :notice => "You are already registered"
	  end
	  @fulfillment = Fulfillment.new
	end

	# GET /fulfillments/1/edit
	def edit
	  @fulfillment = Fulfillment.find(params[:id])
	  if current_user.id != @fulfillment.id
	    redirect_to @fulfillment
	  end
	end
end
