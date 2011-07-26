class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :limit => 50
      t.string :name, :limit => 50
      t.string :bookname, :limit => 50
      t.string :encrypted_password
      t.string :salt
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
