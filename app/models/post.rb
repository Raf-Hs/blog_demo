class Post < ApplicationRecord
  validates :title, presence:true, length: {minimum: 5, maximum:50}
  validates :body, presence:true, length: {minimum: 10, maximum:1000}
  validates :image, presence: true
  validate :valid_rating_range
  has_many :comments, dependent: :destroy
  self.table_name = 'posts'

  def self.ransackable_attributes(auth_object = nil)
    ["body", "title"]
    end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end


  private

  def valid_rating_range
    if rating.present? && (rating < 0 || rating > 5)
      errors.add(:rating, 'must be between 0 and 5')
    end
  end
end
