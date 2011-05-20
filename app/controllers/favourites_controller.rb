class FavouritesController < ApplicationController


  def new
    @favourite = Favourite.new

  end
  def create
    #@recipe = Recipe.find(params[:favourite][:recipe_id])
    @recipe = Recipe.find(params[:recipe])
    current_user.add_favourite!(@recipe)
    redirect_to current_user
  end

  def destroy
    @recipe = Favourite.find(params[:id]).recipe
    current_user.remove_favourite!(@recipe)
    redirect_to @user
  end
  


end
