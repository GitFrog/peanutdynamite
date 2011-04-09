class CreateRecipies < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.text :pic_id
      t.text :title
      t.text :course
      t.timestamp :recDate
      t.timestamp :prepTime
      t.timestamp :cookTime
      t.timestamp :totalTime
      t.text :instructions
      t.integer :yield
      t.text :ingredients
     end
  end

  def self.down
    drop_table :recipes
  end
end
