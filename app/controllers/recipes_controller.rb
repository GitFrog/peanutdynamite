class RecipesController < ApplicationController
  
  layout "application"

  def shortcut
    if params[:id].empty?
      redirect_to root_path(:errormsg => "enter a recipe number")
    elsif Recipe.where(:id => params[:id]).empty?
      redirect_to root_path(:errormsg => "could not find")
    else
      redirect_to recipe_path(params[:id])
    end
  end

  def show

    @recipe = Recipe.find(params[:id]) #grab the recipe...easy enough
    @author_recipe = @recipe.user # now grab author of said recipe
    @story_count = @recipe.stories.where("user_id <> ? AND private = ?", current_user.id, 0).count # alright, how many stories does this recipe have?

    @favourite_recipe = nil # default for now
    @show_my_stories = "no" # default for now
    @my_story_count = 0 # default for now    
    @query = params[:query]
    
    if signed_in?
      fav = current_user.has_favourite_get_rating(@recipe)
      if fav != nil # If this recipe is one of my favourites then...
        @favourite_recipe = fav # Tells the view that this recipe is one of my favourite
        @my_story_count = @recipe.stories.where(:user_id => current_user.id).count             
        if @my_story_count > 0
          @show_my_stories = case params[:show_my_stories] # are we scrolling through my stories, or all stories?
            when nil then "yes" # if not instructed, then scroll through my stories first
            else params[:show_my_stories]
            end
        end
        if @author_recipe == current_user
          @edit_allowed = @recipe.recipe_edit
          @edit_days_remaining = @recipe.recipe_edit_countdown
        end
      else # This is just some recipe I've come across
        @favourite_recipe = "no" # since this is not in my scrapbook, give me option to add it
      end    
    end

    # Alright, now which set of stories should I get first???
    if (@my_story_count > 0 && @show_my_stories == 'yes') #if I have stories then...
        @story = @recipe.stories.where(:user_id => current_user.id).first # Grab my first story
        @author_story = current_user # I'm obviously the author of this story!        
    elsif @story_count > 0 #if this recipe has any stories then...
        @story = @recipe.stories.where("user_id <> ? AND private = ?", current_user.id, 0).first # Grab the first story
        @author_story = @story.user # Get the stories author
        @show_my_stories = 'no'
    end
  end
  
  def new
    @recipe = Recipe.new
    @user = current_user
    @title_right = "Add New Recipe"
    @recipe_button = "Add Recipe"
    @query = params[:query]       
  end  
  
  def create
    @recipe = Recipe.new(params[:recipe])
        
      if @recipe.save
        if Recipefavourite.create(:user => current_user, :recipe_id => @recipe.id, :rating => "maybe")
          if params[:food_tags] != nil
            params[:food_tags][0...4].each do |food_tag|
              Recipetag.create(:recipe_id => @recipe.id, :tag => food_tag)
            end
          end
          @query = {:sort => "new", :course => "all", :pile => "maybe", :page => 0}
           redirect_to users_path(:query => @query)        
        end
      else
        @user = current_user
        @title_left = "Add New Recipe"
        @query = {:sort => "new", :course => "all", :pile => "maybe", :page => 0}
        render 'new'
      end
    end
 
  def edit
    @recipe = Recipe.find(params[:id])
    if (@recipe.user != current_user || @recipe == nil)
      redirect_to @recipe
    else
      @user = current_user
      @author_recipe = @recipe.user
      @title_right = "Edit Your Recipe"
      @recipe_button = "Update"
      @query = {:sort => "new", :course => "all", :pile => "maybe", :page => 0}
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

      if @recipe.update_attributes(params[:recipe])
        redirect_to @recipe
      else
        render :action => "edit"
      end
  end
  
  def destroy
    redirect_to current_user
  end
  
end
