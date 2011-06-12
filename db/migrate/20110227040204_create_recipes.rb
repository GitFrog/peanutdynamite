class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :private
      t.text :ingredients
      t.text :instructions
      t.text :title
      t.text :course
      t.integer :prepTime
      t.integer :cookTime
      t.integer :yield
      t.timestamps
     end
     add_index :user_id
  end

  def self.down
    drop_table :recipes
  end
end
