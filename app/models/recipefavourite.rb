class Recipefavourite < ActiveRecord::Base

  belongs_to :recipe
  belongs_to :user

  #attr_accessible :recipe

  validates :user_id, :presence => true
  validates :recipe_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :recipe_id

end
