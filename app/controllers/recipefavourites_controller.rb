class RecipefavouritesController < ApplicationController

  def new
    @favourite = Favourite.new
  end

  def create
    redirect_to current_user
  end

  def update

    # We've just been told that we need to change a rating on a recipe.  Alright!  Let's do it!
    fav = Recipefavourite.where(:user_id => params[:user_id], :recipe_id => params[:recipe_id]).first
    fav.rating = params[:rating]
    fav.save

    # Following this update, let's head back to the user's scrapbook,
    # making sure to send them back to where they came from (keeper vs recipe)
    redirect_to :action => 'show', :controller => 'users', :keep => (params[:loc])

  end
  
  def destroy

    # If you're here, it means that the user just wants to remove this recipe from
    # their scrapbook, they don't love it, or hate it....they just want it gone.
    # No problem....but we don't remove the actual recipe!  Than would be mad!  Instead, let's
    # just remove the link between this user and this recipe.  Sweet!
    Recipefavourite.where(:user_id => params[:user_id], :recipe_id => params[:recipe_id]).first.destroy
    redirect_to current_user

  end

  


end
