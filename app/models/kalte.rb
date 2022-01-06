class Kalte < ApplicationRecord
  validates :menu, presence: true, length: { maximum: 50 }
  validates :request, presence: true, length: { maximum: 500 }
  validates :menu_description, presence: true, length: { maximum: 500 }
  validates :note, presence: true, length: { maximum: 500 }

  belongs_to :customer
  has_one_attached :image
end
