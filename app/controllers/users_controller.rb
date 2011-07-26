class UsersController < ApplicationController

 
  def index #this shows the users recipe book

    if signed_in?

      items_per_page = 25

      @user = current_user

      # default query setting if it can't find the :query hash
      if params[:query] == nil
        params[:query] = {:sort => "new", :course => "all", :pile => "keeper", :page => 0}
      end

        page = get_page_info(params[:query][:page])
        start_record = page * items_per_page
        end_record = (page+1) * items_per_page

        pile = get_pile_info(params[:query][:pile])

        course = get_course_info(params[:query][:course])

        sort = get_sort_info(params[:query][:sort])

        @query = {:sort => sort, :course => course, :pile => pile, :page => page}

        @title_left = pile.capitalize + "'s: "
        @title_right = course.capitalize

      @recipe = @user.recipes.where("recipefavourites.rating = ?", pile.to_s)
      if course != "all recipes"
        @recipe = @recipe.where("recipes.course = ?", course.to_s)
      end
      
      if sort == "rate"
        @recipes = @recipe.sort_by{|recipe| -recipe.num_of_likes.to_i}[start_record...end_record]
      elsif sort == "mine"
        @recipes = @recipe.where("recipes.user_id = ?", current_user.id).order("created_at DESC")[start_record...end_record]
      else
        @recipes = @recipe.order(sort)[start_record...end_record]
      end
          
    else
      @user = User.new
      render 'new'
    end
  end

  def new
    @user = User.new
    @loginfail = params[:loginfail]
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


def get_page_info(page)
  if page == nil
    return 0
  else
    return case page.to_i
      when -1 then 0
      else page.to_i
    end    
  end
end

def get_pile_info(pile)
  return case pile
    when nil then "keeper"
    else pile
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

def get_sort_info(sort)
  return case sort
    when nil then "created_at DESC"
    when "new" then "created_at DESC"
    when "old" then "created_at ASC"
    when "mine" then "mine"
    when "rate" then "rate"
    when "story" then "story"
  else sort
  end  
end

end