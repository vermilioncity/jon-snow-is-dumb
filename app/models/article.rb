class Article < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10, maximum: 10000 }
  validates :user_id, presence: true


  def self.list_articles(search)
    if search.present?
      search = "%#{search.downcase}%"
      Article.where('content LIKE ?', search).or(Article.where('title LIKE ?', search))
    else
      Article.all
    end
  end

end