class Story < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user


end
