class CreateJoinTableArticlesUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :articles, :users do |t|
      t.index [:article_id, :user_id]
    end
  end
end
