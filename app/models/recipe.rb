class Recipe < ActiveRecord::Base
  has_many :stories
  belongs_to :user
end
