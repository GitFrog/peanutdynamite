class RecipefavouritesController < ApplicationController

  

  def new
    @favourite = Favourite.new
  end

  def create
    redirect_to current_user
  end

  def update
    fav = Recipefavourite.where(:user_id => params[:user_id], :recipe_id => params[:recipe_id]).first
    fav.rating = params[:rating]
    fav.save
    redirect_to :action => 'show', :controller => 'users', :keep => (params[:loc])
  end
  
  def destroy
    Recipefavourite.where(:user_id => params[:user_id], :recipe_id => params[:recipe_id]).first.destroy
    redirect_to current_user
  end

  


end
