class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :firstname
      t.string :lastname
      t.string :encrypted_password, null: false
      t.integer :roles_mask, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique:true
  end
end
