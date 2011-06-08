class Recipe < ActiveRecord::Base

  has_many :recipefavourites
  has_many :users, :through => :recipefavourites
  has_many :stories
  has_many :recipetags

  def my_story_count(current_user_id)
    self.stories.where(:user_id => current_user_id).count.to_s
  end

  def title_concat
    if title.length > 33 then
      title[0..30] + '...'
    else
      title
    end
  end

end
