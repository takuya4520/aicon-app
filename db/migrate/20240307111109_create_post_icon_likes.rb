class CreatePostIconLikes < ActiveRecord::Migration[7.0]
  def change
     create_table :post_icon_likes do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :post_icon_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :post_icon_likes, [:user_id, :post_icon_id], unique: true
  end
end
