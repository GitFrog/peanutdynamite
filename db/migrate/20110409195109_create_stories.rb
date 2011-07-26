class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :recipe_id
      t.integer :user_id
      t.string :title, :limit => 50
      t.text :thestory
      t.string :category, :limit => 15
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.timestamps
    end
    add_index :stories, :user_id
    add_index :stories, :recipe_id
  end

  def self.down
    drop_table :stories
  end
end
