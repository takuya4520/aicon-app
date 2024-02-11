class PostIcon < ApplicationRecord
  belongs_to :user
  has_one_attached :icon do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end
  validates :title, presence: true
  validates :icon, presence: true

  validates :icon,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid icon format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }
end
