class CreateStorytags < ActiveRecord::Migration
  def self.up
    create_table :storytags do |t|
      t.integer :story_id
      t.string :tag, :limit => 20
      t.timestamps
     end
     add_index :storytags, :story_id

  end

  def self.down
    drop_table :story
  end
end