class RecipesController < ApplicationController
  
  layout "application"

  # GET /recipes
  # GET /recipes.xml
  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
      @recipe = Recipe.find(params[:id])
      @story = @recipe.stories.first
      @author = User.find(@recipe.user_id)
      if current_user.has_favourite?(@recipe)
        @myfavourite = true
      else
        @myfavourite = false
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
    @recipe.tag1 = params[:food_tags][0]
    @recipe.tag2 = params[:food_tags][1]
    @recipe.tag3 = params[:food_tags][2]
    @recipe.tag4 = params[:food_tags][3]

    respond_to do |format|
      if @recipe.save
        if Favourite.create(:user => current_user, :recipe_id => @recipe.id, :keeper => "keeper")
          format.html { redirect_to(current_user) }
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
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(recipes_url) }
      format.xml  { head :ok }
    end
  end
end
