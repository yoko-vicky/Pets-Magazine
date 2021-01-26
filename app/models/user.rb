class User < ApplicationRecord
  has_many :articles, dependent: :destroy, foreign_key: :author_id
  has_many :votes, dependent: :destroy
  REGEX_FOR_NAME = /\A[a-zA-Z0-9_]+\z/.freeze
  msg = "can user only letters, numbers and underscores '_'"
  validates :name, presence: true, length: { minimum: 3, maximum: 30 },
                   uniqueness: true, format: { with: REGEX_FOR_NAME, message: msg }

  def already_voted?(article_id)
    votes.find_by(article_id: article_id)
  end

  def ordered_articles
    articles.order_by_created
  end
end
