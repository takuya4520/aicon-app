class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one_attached :current_icon do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end

  validates :current_icon,    content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid icon format" },
                              size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  
  has_many :post_icons
  has_many :created_icons
end
