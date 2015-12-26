class LoginsController < ApplicationController
  
  def new
    
  end

  def create
    #not model backform, no instance varable
    chef = Chef.find_by(email: params[:email])
    # if chef,to validate the chef acutally exist, and not nil
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "You are logged in"
      redirect_to recipes_path
    else
      flash.now[:danger] = "Your email address or password deos not match"
      render 'new'
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end