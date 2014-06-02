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
	    # redirect_to root_path, :notice => "You are already registered"
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

	def oauth
	  if !params[:code]
	    return redirect_to('/')
	  end

	  redirect_uri = url_for(:controller => 'fulfillments', :action => 'oauth', :fulfillment_id => params[:fulfillment_id], :host => request.host_with_port)
	  @fulfillment = Fulfillment.find(params[:fulfillment_id])
	  begin
	    @fulfillment.request_wepay_access_token(params[:code], redirect_uri)
	  rescue Exception => e
	    error = e.message
	  end

	  if error
	    redirect_to @fulfillment, alert: error
	  else
	    redirect_to @fulfillment, notice: 'We successfully connected you to WePay!'
	  end
	end

	def buy
	  redirect_uri = url_for(:controller => 'fulfillments', :action => 'payment_success', :fulfillment_id => params[:fulfillment_id], :host => request.host_with_port)
	  @fulfillment = Fulfillment.find(params[:fulfillment_id])
	  begin
	    @checkout = @fulfillment.create_checkout(redirect_uri)
	  rescue Exception => e
	    redirect_to @fulfillment, alert: e.message
	  end
	end

	# GET /fulfillments/payment_success/1
	def payment_success
	  @fulfillment = Fulfillment.find(params[:fulfillment_id])
	  if !params[:checkout_id]
	    return redirect_to @fulfillment, alert: "Error - Checkout ID is expected"
	  end
	  if (params['error'] && params['error_description'])
	    return redirect_to @fulfillment, alert: "Error - #{params['error_description']}"
	  end
	  redirect_to @fulfillment, notice: "Thanks for the payment! You should receive a confirmation email shortly."
	end
end
