class CreateStorytags < ActiveRecord::Migration
  def self.up
    create_table :storytags do |t|
      t.integer :story_id
      t.text :tag
      t.timestamps
     end
     add_index :stories

  end

  def self.down
    drop_table :story
  end
end