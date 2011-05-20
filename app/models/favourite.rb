class Favourite < ActiveRecord::Base

  belongs_to :recipe
  belongs_to :user

  #attr_accessible :recipe

  validates :user_id, :presence => true
  validates :recipe_id, :presence => true

end
