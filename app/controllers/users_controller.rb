class UsersController < ApplicationController

 
  def show #this shows the users recipe book

    if signed_in?

      items_per_page = 25

      @user = current_user

      # default query setting if it can't find the :query hash
      if params[:query] == nil
        params[:query] = {
            :sort => "new",
            :course => "all",
            :pile => "keeper",            
            :page => 0}
      end


      if params[:query][:page] == nil
        page = 0
      else
        page = case params[:query][:page].to_i
          when -1 then 0
          else params[:query][:page].to_i
        end
      end

      start_record = page * items_per_page
      end_record = (page+1) * items_per_page

      pile = case params[:query][:pile]
        when nil then "keeper"
        else params[:query][:pile]
      end

      course = case params[:query][:course]
        when nil then "all recipes"
        when "all" then "all recipes"
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
      else params[:query][:course]
      end

      sort = case params[:query][:sort]
        when nil then "created_at DESC"
        when "new" then "created_at DESC"
        when "old" then "created_at ASC"
        when "chef" then "user_id"
        when "rate" then "rate"
        when "story" then "story"
      else params[:query][:sort]
      end

      look_for_this = "recipefavourites.rating = '" + pile.to_s + "'"
      if course != "all recipes"
        look_for_this += " AND recipes.course = '" + course.to_s + "'"
      end

       @query = {
         :sort => sort,
         :course => course,
         :pile => pile,
         :page => page}

      @title_left = pile.capitalize + "'s: "
      @title_right = course.capitalize

      if sort == "rate"
        @recipes = @user.recipes.where(look_for_this).sort_by{|recipe| -recipe.num_of_likes.to_i}[start_record...end_record]
      elsif sort == "story"
        @recipes = @user.recipes.where(look_for_this).sort_by{|recipe| -recipe.all_story_count.to_i}[start_record...end_record]
      else
        @recipes = @user.recipes.where(look_for_this).order(sort)[start_record...end_record]
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
