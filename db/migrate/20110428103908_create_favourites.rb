class CreateFavourites < ActiveRecord::Migration
  def self.up
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.text :keeper
      t.timestamps
     end
     add_index :favourites, :user_id
     add_index :favourites, :recipe_id
     add_index :favourites, [:user_id, :recipe_id], :unique => true
  end

  def self.down
    drop_table :favourites
  end
end
