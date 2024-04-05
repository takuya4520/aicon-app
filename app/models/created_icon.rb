class CreatedIcon < ApplicationRecord
  belongs_to :user
  has_one_attached :icon do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end
  has_many :created_icon_likes, dependent: :destroy
  validates :title, presence: true
  validates :icon, presence: true

  validates :icon,   content_type: { in: %w[image/jpeg image/gif image/png image/webp],
                                      message: "must be a valid icon format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }
  enum status: { published: 0, unpublished: 1 }

  def thumbnail
    return self.icon.variant(resize: '300x300').processed
  end
end
