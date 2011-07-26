class Story < ActiveRecord::Base

  belongs_to :recipe
  belongs_to :user
  has_many :storytags

  has_attached_file :photo, :styles => {:thumb=> "50x50#", :small=> "250x250#" }

  validates :thestory,      :presence => true,
                            :length => { :maximum => 3000 }

  validates :title,         :presence => true,
                            :length => { :maximum => 40 }

  validates :category,      :presence => true

  def title_concat
    if title.length > 39 then
      title[0..36] + '...'
    else
      title
    end
  end

  def previous_story
    self.class.first(:conditions => ["id < ? AND recipe_id = ?", id, self.recipe_id], :order => "id desc")
  end

  def next_story
    self.class.first(:conditions => ["id > ? AND recipe_id = ?", id, self.recipe_id], :order => "id asc")
  end

  def my_first_story
    self.class.first(:conditions => ["recipe_id = ? AND user_id = ?", self.recipe_id, self.user_id], :order => "id asc")
  end

  def my_previous_story
    self.class.first(:conditions => ["id < ? AND recipe_id = ? AND user_id = ?", id, self.recipe_id, self.user_id], :order => "id desc")
  end

  def my_next_story
    self.class.first(:conditions => ["id > ? AND recipe_id = ? AND user_id = ?", id, self.recipe_id, self.user_id], :order => "id asc")
  end

  def my_story_location
    (self.class.count(:conditions => ["id < ? AND recipe_id = ? AND user_id = ?", id, self.recipe_id, self.user_id]) + 1).to_s + "/" + self.class.count(:conditions => ["recipe_id = ? AND user_id = ?", self.recipe_id, self.user_id]).to_s
  end
  
  def story_location
    (self.class.count(:conditions => ["id < ? AND recipe_id = ?", id, self.recipe_id]) + 1).to_s + "/" + self.class.count(:conditions => ["recipe_id = ?", self.recipe_id]).to_s
  end
end
