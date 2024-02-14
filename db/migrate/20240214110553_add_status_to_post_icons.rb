class AddStatusToPostIcons < ActiveRecord::Migration[7.0]
  def change
    add_column :post_icons, :status, :integer, default: 0, null: false
  end
end
