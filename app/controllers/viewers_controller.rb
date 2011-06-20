class ViewersController < ApplicationController

 def show #this shows the users recipe book

      items_per_page = 18

      @page = case params[:page].to_i
        when nil then 0
        when -1 then 0
        else params[:page].to_i
      end

      start_record = @page * items_per_page
      end_record = (@page+1) * items_per_page

      @course = case params[:course]
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
      else params[:course]
      end

      @sortby = case params[:sortby]
        when nil then "created_at DESC"
        when "new" then "created_at DESC"
        when "old" then "created_at ASC"
        when "chef" then "user_id"
        when "rate" then "rate"
        when "story" then "story"
      else params[:sortby]
      end

      if @course == nil then
        if @sortby == "rate"
          @recipes = Recipe.all.sort_by{|recipe| -recipe.rating_equation.to_i}[start_record...end_record]
        elsif @sortby == "story"
          @recipes = Recipe.all.sort_by{|recipe| -recipe.all_story_count.to_i}[start_record...end_record]
        else
          @recipes = Recipe.order(@sortby)[start_record...end_record]
        end
      else
        if @sortby == "rate"
          @recipes = Recipe.where("recipes.course = ?" , @course).sort_by{|recipe| -recipe.num_of_likes.to_i}[start_record...end_record]
        elsif @sortby == "story"
          @recipes = Recipe.where("recipes.course = ?", @course).sort_by{|recipe| -recipe.all_story_count.to_i}[start_record...end_record]
        else
          @recipes = Recipe.where("recipes.course = ?", @course).order(@sortby)[start_record...end_record]
        end
      end
   end
end
