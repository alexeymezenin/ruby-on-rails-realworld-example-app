class CreateJoinTableArticlesTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :articles, :tags do |t|
      t.index %i[:article_id, :tag_id]
    end
  end
end
