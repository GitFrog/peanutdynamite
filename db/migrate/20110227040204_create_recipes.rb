class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :pic_id
      t.text :title
      t.text :course
      t.timestamp :recDate
      t.integer :prepTime
      t.integer :cookTime
      t.integer :totalTime
      t.text :instructions
      t.integer :yield
      t.text :ingredients
      t.timestamps
     end
  end

  def self.down
    drop_table :recipes
  end
end
