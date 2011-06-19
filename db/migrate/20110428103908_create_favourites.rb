class CreateFavourites < ActiveRecord::Migration

  def self.down
    drop_table :favourites
  end
  
end
