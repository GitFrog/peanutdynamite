class Story < ActiveRecord::Base

  belongs_to :recipe
  belongs_to :user

  has_attached_file :photo, :styles => {:thumb=> "50x50#", :small=> "250x250#" }

  def previous_story
    self.class.first(:conditions => ["id < ? AND recipe_id = ?", id, self.recipe_id], :order => "id desc")
  end

  def next_story
    self.class.first(:conditions => ["id > ? AND recipe_id = ?", id, self.recipe_id], :order => "id asc")
  end

  


end
