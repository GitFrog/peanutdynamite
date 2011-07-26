class Storytag < ActiveRecord::Base
  belongs_to :story

  validates_uniqueness_of :tag, :scope => :story_id
end
