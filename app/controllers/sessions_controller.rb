class SessionsController < ApplicationController
  # GET /sessions/new
def new
end

# POST /sessions
def create
  fulfillment = Fulfillment.authenticate params[:email], params[:password]
    if fulfillment
      session[:fulfillment_id] = fulfillment.id
      redirect_to root_path, :notice => "Welcome back to HomeStreetHome"
    else
      redirect_to :login, :alert => "Invalid email or password"
    end
end

def destroy
  session[:fulfillment_id] = nil
  redirect_to root_path :notice => "You have been logged out"
end
end
