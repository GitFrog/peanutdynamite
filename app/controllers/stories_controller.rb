class StoriesController < ApplicationController

  def show
      @story = Story.find(params[:id])
      @recipe = @story.recipe
      @author_recipe = User.find(@recipe.user_id)
      @author_story = User.find(@story.user_id)
      if current_user.has_favourite?(@recipe)
        @myfavourite = true
        @mystories = case params[:mystories]
        when nil then '1'
        else params[:mystories]
        end
      else
        @myfavourite = false
        @mystories = '0'
      end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @story = Story.new
    @author_recipe = User.find(@recipe.user_id)
    #redirect_to @user
    #@story = Story.new
  end

   def create
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to(@story) }
        #format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        #format.html { render :action => "new" }
        #format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

end
