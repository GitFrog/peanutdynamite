class UsersController < ApplicationController

 
  def show #this shows the users recipe book
    if signed_in?

      items_per_page = 20

      @user = current_user

      @keep = case params[:keep]
        when nil then "keeper"
        when "k" then "keeper"
        when "m" then "maybe"
        else params[:keep]
      end

      @show = case params[:show]
        when nil then nil
        when "all" then nil
        when "app" then "appetizer"
        when "soup" then "soup, stew"
        when "salad" then "salad"            
        when "sauce" then "sause"
        when "side" then "side"
        when "main" then "main"
        when "sweet" then "sweet"
        when "breaky" then "breakfast"
        when "brd" then "bread"
        when "bev" then "beverage"
        when "presv" then "preserves"
      else params[:show]
      end

      @sort = case params[:sort]
        when nil then "created_at DESC"
        when "new" then "created_at DESC"
        when "old" then "created_at ASC"
        when "chef" then "user_id"
        when "rate" then nil
        when "view" then nil
        when "story" then nil
      else params[:sort]
      end


      if @show == nil
        @recipes = @user.recipes.where("favourites.keeper = ?", @keep).order(@sort).limit(items_per_page)
      else
         @recipes = @user.recipes.where("recipes.course = ? AND favourites.keeper = ?", @show, @keep).order(@sort).limit(items_per_page)
      end
        
     
    else
      @user = User.new
      render 'new'
    end
  end

   def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

end
