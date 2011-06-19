class CreateRecipetags < ActiveRecord::Migration
  def self.up
    create_table :recipetags do |t|
      t.integer :recipe_id
      t.string :tag, :limit => 20
      t.timestamps
     end
     add_index :recipes

  end

  def self.down
    drop_table :recipetags
  end
end

