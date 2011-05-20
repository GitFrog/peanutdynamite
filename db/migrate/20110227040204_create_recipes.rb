class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :pic_id
      t.text :title
      t.text :instructions
      t.text :ingredients
      t.integer :prepTime
      t.integer :cookTime
      t.integer :totalTime
      t.integer :yield
      t.text :tag1
      t.text :tag2
      t.text :tag3
      t.text :tag4
      t.timestamps
     end
  end

  def self.down
    drop_table :recipes
  end
end
