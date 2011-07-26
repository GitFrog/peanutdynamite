class Recipetag < ActiveRecord::Base
  belongs_to :recipe

  validates_uniqueness_of :tag, :scope => :recipe_id
end