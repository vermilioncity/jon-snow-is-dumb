class Picture < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  default_scope -> { order(created_at: :asc) }
  validates :picture, presence: true
  validates :description, presence: true, length: { minimum: 1, maximum: 10000 }
  mount_uploader :picture, PictureUploader

end
