class Recipe < ActiveRecord::Base

  has_many :recipefavourites
  has_many :users, :through => :recipefavourites
  belongs_to :user
  has_many :stories
  has_many :recipetags

  validates :ingredients,   :presence => true,
                            :length => { :maximum => 3000 }

  validates :instructions,  :presence => true,
                            :length => { :maximum => 3000 }

  validates :title,         :presence => true,
                            :length => { :maximum => 100 },
                            :uniqueness => { :case_sensitive => false }

  validates :course,        :presence => true


  def my_story_count(current_user_id)
    self.stories.where(:user_id => current_user_id).count.to_s
  end

  def all_story_count
    self.stories.count.to_s
  end

  def newest_story
    self.stories.order("created_at DESC").first
  end

  def title_concat
    if title.length > 36 then
      title[0..33] + '...'
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
