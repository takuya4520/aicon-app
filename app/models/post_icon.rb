class PostIcon < ApplicationRecord
  belongs_to :user
  has_one_attached :icon do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end
  validates :title, presence: true
  validates :icon, presence: true
  has_many :post_icon_likes, dependent: :destroy

  validates :icon,   content_type: { in: %w[image/jpeg image/gif image/png image/webp],
                                      message: "must be a valid icon format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }
  enum status: { published: 0, unpublished: 1 }
end
