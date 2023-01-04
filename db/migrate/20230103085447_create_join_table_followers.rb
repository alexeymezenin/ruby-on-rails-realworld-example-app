class CreateJoinTableFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table 'followers' do |t|
      t.integer :follower_id
      t.integer :following_id
    end

    change_column_null :followers, :follower_id, true
    change_column_null :followers, :following_id, true
    add_index :followers, :follower_id
    add_index :followers, :following_id
  end
end
