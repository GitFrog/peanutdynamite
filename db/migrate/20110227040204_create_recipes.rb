class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :private
      t.text :ingredients
      t.text :instructions
      t.string :title, :limit => 100
      t.string :course, :limit => 12
      t.integer :prepTime
      t.integer :cookTime
      t.integer :yield
      t.timestamps
     end
     add_index :user_id, :title
  end

  def self.down
    drop_table :recipes
  end
end
