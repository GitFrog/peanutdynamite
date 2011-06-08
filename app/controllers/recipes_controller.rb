class RecipesController < ApplicationController
  
  layout "application"
  
  def show
      @recipe = Recipe.find(params[:id])
      @author_recipe = User.find(@recipe.user_id)
      @story_count = @recipe.stories.count
      if current_user.has_favourite?(@recipe)
        @myfavourite = true
        @mystories = case params[:mystories]
            when nil then '1'
            else params[:mystories]
            end
        @story = @recipe.stories.where(:user_id => current_user.id).first
        @author_story = User.find(@story.user_id)
        @my_story_count = @recipe.stories.where(:user_id => current_user.id).count
      else
        @myfavourite = false
        @mystories = '0'
        @story = @recipe.stories.first
        @author_story = User.find(@story.user_id)
      end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.xml
  def new
    @recipe = Recipe.new
    @user = current_user
    @keep = "Add New Recipe"
    @show = ""
    #redirect_to @user
    #@story = Story.new
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.new(params[:recipe])
    
    respond_to do |format|
      if @recipe.save
        if Recipefavourite.create(:user => current_user, :recipe_id => @recipe.id, :rating => "maybe")
          params[:food_tags][0...4].each do |food_tag|
            Recipetag.create(:recipe_id => @recipe.id, :tag => food_tag)
          end
          format.html { redirect_to :action => 'show', :controller => 'users', :keep => "maybe" }
          #format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
        else
          @recipe.destroy
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
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

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    redirect_to current_user
  end
end
