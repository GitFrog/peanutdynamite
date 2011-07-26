class StoriesController < ApplicationController

  def show
    
    @story = Story.find(params[:id])
    @recipe = @story.recipe
    @author_recipe = @recipe.user
    @author_story = @story.user
    
    @favourite_recipe = nil # default for now
   
    if signed_in?
      fav = current_user.has_favourite_get_rating(@recipe)
      if fav != nil # If this recipe is one of my favourites then...
        @favourite_recipe = fav # Tells the view that this recipe is one of my favourite              
      else # This is just some recipe I've come across
        @favourite_recipe = "no" # since this is not in my scrapbook, give me option to add it
      end    
    end      
   
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @story = Story.new
    @author_recipe = @recipe.user    
  end

   def create
    @story = Story.new(params[:story])

      if @story.save
        if params[:story_tags] != nil
          params[:story_tags][0...4].each do |story_tag|
          Storytag.create(:story_id => @story.id, :tag => story_tag)
          end
          redirect_to @story
        end
      else
        render 'new'
      end    
  end

end
