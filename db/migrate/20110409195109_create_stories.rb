class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.text :recipe_id
      t.text :user_id
      t.text :pic_id
      t.text :story
      t.timestamp :storyDate
    end
  end

  def self.down
    drop_table :stories
  end
end
