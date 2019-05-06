class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10, maximum: 10000 }
  validates :user_id, presence: true




  def self.list_articles(search)
    if search.present?
      search = "%#{search}%"
      Article.where('content ILIKE ?', search).or(Article.where('title ILIKE ?', search))
    else
      Article.all
    end
  end

end