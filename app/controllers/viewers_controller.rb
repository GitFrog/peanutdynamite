class ViewersController < ApplicationController

 def index #this shows the users recipe book

      # default query setting if it can't find the :query hash
      if params[:course] != nil && params[:sort] != nil && params[:page] != nil
        params[:query] = {:sort => params[:sort], :course => params[:course], :foodtag => params[:foodtag], :page => params[:page]}
      elsif params[:query] == nil
        params[:query] = {:sort => "new", :course => "all", :foodtag => nil, :page => 0}
      end

      items_per_page = 18
      page = get_page_number(params[:query][:page])
      start_record = page * items_per_page
      end_record = (page+1) * items_per_page

      course = get_course_info(params[:query][:course])
        
      foodtag = params[:query][:foodtag]

      sort = get_sort_info(params[:query][:sort])

      @query = {:sort => sort, :course => course, :foodtag => foodtag, :page => page}
        
      @title_left = "Courses : "
      @title_right = course.capitalize
      @action = 'index'
      
      # TIME TO BUILD OUT MODEL OBJECT.  WOHOO!!!
      @recipe = Recipe
      if (foodtag != nil && foodtag != "")
        @recipe = @recipe.joins(:recipetags).where("recipetags.tag = ?", foodtag)
        @title_more_right = "  ( filter by '" + foodtag.downcase + "' )"
      end
      @recipe = @recipe.where("private = 0")
      if course != "all recipes"
        @recipe = @recipe.where("course = ?", course)
      end
      if sort == "rate"
        @recipes = @recipe.all.sort_by{|recipe| -recipe.rating_equation.to_i}[start_record...end_record]
      elsif sort == "story"
        @recipes = @recipe.all.sort_by{|recipe| -recipe.all_story_count.to_i}[start_record...end_record]
      else
        @recipes = @recipe.order(sort)[start_record...end_record]
      end
     
   end

  def indexstories #this shows the users recipe book

      # default query setting if it can't find the :query hash
      if params[:sort] != nil && params[:page] != nil
        params[:query] = {:emo => params[:emo], :sort => params[:sort], :storytag => params[:storytag], :page => params[:page]}
      elsif params[:query] == nil
        params[:query] = {:emo => params[:emo], :sort => "new", :storytag => nil, :page => 0}
      end

      items_per_page = 18
      page = get_page_number(params[:query][:page])
      start_record = page * items_per_page
      end_record = (page+1) * items_per_page

      storytag = params[:query][:storytag]

      sort = get_sort_info(params[:query][:sort])

      emo = get_emo_info(params[:query][:emo])

      @query = {:emo => emo, :sort => sort, :storytag => storytag, :page => page}

      @title_left = "Stories : "
      @title_right = emo
      @action = 'indexstories'
      
      # TIME TO BUILD OUT MODEL OBJECT.  WOHOO!!!
      @stories = Story
      if (storytag != nil && storytag != "")
        @stories = @stories.joins(:storytags).where("storytags.tag = ?", storytag)
        @title_more_right = "  ( filter by '" + storytag.downcase + "' )"
      end
      @stories = @stories.where("stories.category = ?", emo).order(sort)[start_record...end_record]
      #if sort == "rate"
        #@stories = @stories.all.sort_by{|story| -recipe.rating_equation.to_i}[start_record...end_record]
      #else
        #@stories = @stories.order(sort)[start_record...end_record]
      #end

   end

  def get_page_number(page)
    if page == nil
      return 0
    else
      p = case page.to_i
        when -1 then 0
        else page.to_i
      end
      return p
    end
  end

  def get_sort_info(sort)
    return case sort
      when nil then "created_at DESC"
      when "new" then "created_at DESC"
      when "old" then "created_at ASC"
      when "author" then "user_id"
      when "rate" then "rate"
      else sort
    end
  end

  def get_emo_info(emo)
    return case emo
      when nil then "life is sweet"
      when "sweet" then "life is sweet"
      when "bite" then "bite me"
      else emo
    end
  end

  def get_course_info(course)
    return case course
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
        else course
    end
  end



end



