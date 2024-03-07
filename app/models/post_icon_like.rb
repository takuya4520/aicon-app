class PostIconLike < ApplicationRecord
  belongs_to :user
  belongs_to :post_icon

  validates :user_id, uniqueness: { scope: :post_icon_id }
end
