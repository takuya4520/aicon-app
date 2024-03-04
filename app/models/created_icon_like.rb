class CreatedIconLike < ApplicationRecord
  belongs_to :user
  belongs_to :created_icon

  validates :user_id, uniqueness: { scope: :created_icon_id }
end
