class StoriesController < ApplicationController

  def show
    
    @story = Story.find(params[:id])
    @recipe = @story.recipe
    @author_recipe = @recipe.user
    @author_story = @story.user
    
    @favourite_recipe = nil # default for now

    if @author_story == current_user
      @show_my_stories = 'yes'
    else
      @show_my_stories = 'no'
    end
    
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
        end
        respond_to do |format|
          format.html {redirect_to @story}
        end
      else
        @recipe = @story.recipe
        @author_recipe = @recipe.user
        render 'new'
      end    
  end

  def edit
    @story = Story.find(params[:id])
    if (@story.user != current_user || @story == nil)
      redirect_to @story
    else
      @recipe = @story.recipe
      @author_recipe = @recipe.user
    end
  end

  def update
    @story = Story.find(params[:id])

      if @story.update_attributes(params[:story])
        redirect_to @story
      else
        render :action => "edit"
      end
  end

  def destroy
    @story = Story.find(params[:id])
    @recipe = @story.recipe
    
    if (@story.user != current_user || @story == nil)
      render 'show'
    else
      @story.destroy
      redirect_to @recipe
    end
  end
  end

