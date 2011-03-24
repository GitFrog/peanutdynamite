class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.text :title
      t.text :story
      t.text :recipe
      t.timestamp :created_on
      t.integer :pic_id

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
