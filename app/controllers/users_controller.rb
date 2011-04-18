class UsersController < ApplicationController

  def index
    
  end

  def show
    if signed_in?
      @user = current_user
    else
      @user = User.new
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
end
