class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.text :private
      t.text :title
      t.text :instructions
      t.text :ingredients
      t.text :course
      t.integer :prepTime
      t.integer :cookTime
      t.integer :yield
      t.timestamps
     end
  end

  def self.down
    drop_table :recipes
  end
end
