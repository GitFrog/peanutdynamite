class RecipesController < ApplicationController
  
  layout "application"

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


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end
  
  def new
    @recipe = Recipe.new
    @user = current_user
    @title_left = "Add New Recipe"
    @query = params[:query]       
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
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
 
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    redirect_to current_user
  end
end
