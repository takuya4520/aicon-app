class PostIcon < ApplicationRecord
  belongs_to :user
  has_one_attached :icon

  validates :title, presence: true
  validates :icon, presence: true
end
