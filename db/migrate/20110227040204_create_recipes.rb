class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :private
      t.text :ingredients, :limit => 3000
      t.text :instructions, :limit => 3000
      t.string :title, :limit => 100
      t.string :course, :limit => 12
      t.string :prepTime, :limit => 10
      t.string :cookTime, :limit => 10
      t.integer :yield
      t.timestamps
     end
     add_index :recipes, :user_id
     add_index :recipes, :title
  end

  def self.down
    drop_table :recipes
  end
end
