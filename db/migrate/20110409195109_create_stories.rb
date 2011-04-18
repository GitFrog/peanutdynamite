class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :recipe_id
      t.integer :user_id
      t.integer :pic_id
      t.text :story
      t.text :category
      t.timestamp :storyDate
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
