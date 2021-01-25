class Category < ApplicationRecord
  before_save { self.name = name.capitalize if name }
  has_many :articles
  validates :name, presence: true, length: { minimum: 2, maximum: 16 }, uniqueness: { case_sensitive: false }
  validates :priority, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 9 }

  scope :prioritize, -> { order(:priority) }
end
