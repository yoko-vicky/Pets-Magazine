class Article < ApplicationRecord
  before_save { self.title = title.capitalize if title }

  belongs_to :author, class_name: 'User'
  belongs_to :category
  has_many :votes, dependent: :destroy
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }

  has_one_attached :image
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :text, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :category_id, presence: true

  scope :order_by_created, -> { order(created_at: :desc) }
  scope :latest16, -> { limit(16) }
  scope :latest, -> { order(created_at: :desc).limit(1).first }
end
