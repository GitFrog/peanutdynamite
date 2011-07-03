class ViewersController < ApplicationController

 def show #this shows the users recipe book

      items_per_page = 18

      # default query setting if it can't find the :query hash
      if params[:course] != nil && params[:sort] != nil && params[:page] != nil
        params[:query] = {:sort => params[:sort], :course => params[:course], :foodtag => params[:foodtag], :page => params[:page]}
      elsif params[:query] == nil
        params[:query] = {:sort => "new", :course => "all", :foodtag => nil, :page => 0}
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

      foodtag = params[:query][:foodtag]

      sort = case params[:query][:sort]
        when nil then "created_at DESC"
        when "new" then "created_at DESC"
        when "old" then "created_at ASC"
        when "chef" then "user_id"
        when "rate" then "rate"
        when "story" then "story"
      else params[:query][:sort]
      end

      @query = {:sort => sort, :course => course, :foodtag => foodtag, :page => page}
        
      @title_left = "Courses : "
      @title_right = course.capitalize
      
      # TIME TO BUILD OUT MODEL OBJECT.  WOHOO!!!
      @recipe = Recipe
      if (foodtag != nil && foodtag != "")
        look_for_this_foodtag = "recipetags.tag = " + "'" + foodtag + "'"
        @recipe = @recipe.joins(:recipetags).where(look_for_this_foodtag)
        @title_more_right = "  (filtered by " + foodtag.downcase + ")"
      end
      if course != "all recipes"
        look_for_this_course = "course = " + "'" + course +"'"
        @recipe = @recipe.where(look_for_this_course)
      end
      if sort == "rate"
        @recipes = @recipe.all.sort_by{|recipe| -recipe.rating_equation.to_i}[start_record...end_record]
      elsif sort == "story"
        @recipes = @recipe.all.sort_by{|recipe| -recipe.all_story_count.to_i}[start_record...end_record]
      else
        @recipes = @recipe.order(sort)[start_record...end_record]
      end
     
   end
end
