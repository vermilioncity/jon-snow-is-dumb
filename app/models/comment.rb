class Comment < ApplicationRecord
  belongs_to :user, optional: true
  validates :body, presence: true, allow_blank: false
  belongs_to :commentable, polymorphic: true
end
