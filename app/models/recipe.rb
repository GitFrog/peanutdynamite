class Recipe < ActiveRecord::Base

  has_many :recipefavourites
  has_many :users, :through => :recipefavourites
  has_many :stories
  has_many :recipetags

  def my_story_count(current_user_id)
    self.stories.where(:user_id => current_user_id).count.to_s
  end

  def all_story_count
    self.stories.count.to_s
  end

  def title_concat
    if title.length > 39 then
      title[0..36] + '...'
    else
      title
    end
  end
  
  def num_of_likes
    self.recipefavourites.where(:rating => "keeper").count
  end
  
  def num_of_hates
    self.recipefavourites.where(:rating => "hate").count
  end

  def rating_equation
    num_of_likes - num_of_hates
  end



end
