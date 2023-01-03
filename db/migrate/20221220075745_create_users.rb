class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :image
      t.text :bio

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    change_column_null :users, :image, true
    change_column_null :users, :bio, true
  end
end
