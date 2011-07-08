class StoriesController < ApplicationController

  def show
    
    @story = Story.find(params[:id])
    @recipe = @story.recipe
    @author_recipe = @recipe.user
    @author_story = @story.user
    @story_count = @recipe.stories.count # alright, how many stories does this recipe have?
    
    @favourite_recipe = nil # default for now
    @show_my_stories = "no" # default for now
    @my_story_count = 0 # default for now

    if signed_in?
      fav = current_user.has_favourite_get_rating(@recipe)
      if fav != nil # If this recipe is one of my favourites then...
        @favourite_recipe = fav # Tells the view that this recipe is one of my favourite
        @my_story_count = @recipe.stories.where(:user_id => current_user.id).count
        @show_my_stories = case params[:show_my_stories] # are we scrolling through my stories, or all stories?
          when nil then "yes" # if not instructed, then scroll through my stories first
          else params[:show_my_stories]
          end        
      else # This is just some recipe I've come across
        @favourite_recipe = "no" # since this is not in my scrapbook, give me option to add it
      end    
    end
      
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @story = Story.new
    @author_recipe = @recipe.user
    #redirect_to @user
    #@story = Story.new
  end

   def create
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        if params[:story_tags] != nil
          params[:story_tags][0...4].each do |story_tag|
          Storytag.create(:story_id => @story.id, :tag => story_tag)
          end
          format.html {redirect_to @story}
        end
      else


        format.html { render new_story_path }
        #format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

end
