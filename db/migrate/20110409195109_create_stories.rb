class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :recipe_id
      t.integer :user_id
      t.integer :pic_id
      t.text :title
      t.text :thestory
      t.text :category
      t.text :photo_file_name
      t.text :photo_content_type
      t.integer :photo_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
