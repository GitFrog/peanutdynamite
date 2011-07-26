class RecipefavouritesController < ApplicationController

  def new
    @favourite = Favourite.new
  end

  def create    
    # The user likes this recipe and wants it added to their book.  Let's get to work!
    Recipefavourite.create(:user_id => params[:user_id], :recipe_id => params[:recipe_id], :rating => 'maybe')
    redirect_to :action => 'show', :controller => 'recipes', :id => params[:recipe_id]
  end

  def update
    # We've just been told that we need to change a rating on a recipe.  Alright!  Let's do it!
    fav = Recipefavourite.where(:user_id => params[:user_id], :recipe_id => params[:recipe_id]).first
    fav.rating = params[:sendto]
    fav.save
    # Following this update, let's head back to the user's scrapbook,
    # making sure to send them back to where they came from (keeper vs maybe)
    if params[:redirect] == nil # User is updating from scrapbook, so head back there
      redirect_to :action => 'index', :controller => 'users', :query => params[:query]
    else # User is updating from within a recipe, so head back to it
      redirect_to :action => 'show', :controller => 'recipes', :id => params[:recipe_id]
    end
  end
  
  def destroy
    # If you're here, it means that the user just wants to remove this recipe from
    # their scrapbook, they don't love it, or hate it....they just want it gone.
    # No problem....but we don't remove the actual recipe!  That would be mad! MAD!
    # Instead, let's just remove the link between this user and this recipe.  Sweet!
    Recipefavourite.where(:user_id => params[:user_id], :recipe_id => params[:recipe_id]).first.destroy
    redirect_to :action => 'index', :controller => 'users', :query => params[:query]
  end
  
end
