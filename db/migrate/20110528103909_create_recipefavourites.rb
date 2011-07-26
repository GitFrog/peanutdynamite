class CreateRecipefavourites < ActiveRecord::Migration
  def self.up
    create_table :recipefavourites do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.string :rating, :limit => 6
      t.text :modification
      t.timestamps
     end
     add_index :recipefavourites, :user_id
     add_index :recipefavourites, :recipe_id
  end

  def self.down
    drop_table :recipefavourites
  end
end