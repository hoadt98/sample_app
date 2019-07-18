class Micropost < ApplicationRecord
  belongs_to :user
  scope :micropost_order, -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.content_max }
end
