class CreatePostIcons < ActiveRecord::Migration[7.0]
  def change
    create_table :post_icons do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
    add_index :post_icons, [:user_id, :created_at]
  end
end
