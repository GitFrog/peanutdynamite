class SessionsController < ApplicationController
  
  def new    
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
                           flash.now[:error] = user.to_s
    if user.nil?
      redirect_to url_for(new_user_path(:loginfail => true))
    else
      sign_in user
      redirect_to users_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
