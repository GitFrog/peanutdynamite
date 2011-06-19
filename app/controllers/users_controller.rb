class UsersController < ApplicationController

 
  def show #this shows the users recipe book

    if signed_in?

      items_per_page = 25

      @user = current_user

      @page = case params[:page].to_i
        when nil then 0
        when -1 then 0
        else params[:page].to_i
      end

      start_record = @page * items_per_page
      end_record = (@page+1) * items_per_page

      @keep = case params[:keep]
        when nil then "keeper"
        else params[:keep]
      end

      @show = case params[:show]
        when nil then nil
        when "all" then nil
        when "app" then "appetizer"
        when "soup" then "soup, stew"
        when "salad" then "salad"            
        when "sauce" then "sauce"
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
        when "rate" then "rate"
        when "story" then "story"
      else params[:sort]
      end

      if @show == nil
        if @sort == "rate"
          @recipes = @user.recipes.where("recipefavourites.rating = ?", @keep).sort_by{|recipe| -recipe.num_of_likes.to_i}[start_record...end_record]
        elsif @sort == "story"
          @recipes = @user.recipes.where("recipefavourites.rating = ?", @keep).sort_by{|recipe| -recipe.all_story_count.to_i}[start_record...end_record]
        else
          @recipes = @user.recipes.where("recipefavourites.rating = ?", @keep).order(@sort)[start_record...end_record]
        end
      else
         if @sort == "rate"
          @recipes = @user.recipes.where("recipes.course = ? AND recipefavourites.rating = ?", @show, @keep).sort_by{|recipe| -recipe.num_of_likes.to_i}[start_record...end_record]
        elsif @sort == "story"
          @recipes = @user.recipes.where("recipes.course = ? AND recipefavourites.rating = ?", @show, @keep).sort_by{|recipe| -recipe.all_story_count.to_i}[start_record...end_record]
        else
          @recipes = @user.recipes.where("recipes.course = ? AND recipefavourites.rating = ?", @show, @keep).order(@sort)[start_record...end_record]
        end
      end

      if @recipes == nil then
        #@page -= 1
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
