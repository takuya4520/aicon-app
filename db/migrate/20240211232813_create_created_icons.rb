class CreateCreatedIcons < ActiveRecord::Migration[7.0]
  def change
    create_table :created_icons do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :taste, null: false

      t.timestamps
    end
    add_index :created_icons, [:user_id, :created_at]
  end
end
