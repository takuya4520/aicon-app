class CreatedIcon < ApplicationRecord
  belongs_to :user
  has_one_attached :icon do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end
  
  has_many :created_icon_likes, dependent: :destroy
  
  #繰り返し禁止バリデーション
  NGWORD_REGEX = /(.)\1{4,}/.freeze
 
  with_options presence: true do 
    with_options format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' } do
      validates :title
    end
    validates :icon
  end
  validates :icon,   content_type: { in: %w[image/jpeg image/gif image/png image/webp],
                                      message: "must be a valid icon format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }
  enum status: { published: 0, unpublished: 1 }

  validate :title_cannot_contain_blacklist_words

end
