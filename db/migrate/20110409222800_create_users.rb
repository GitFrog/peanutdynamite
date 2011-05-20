class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.text :email
      t.text :name
      t.text :bookname
      t.text :encrypted_password
      t.text :salt
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
