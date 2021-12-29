class Kalte < ApplicationRecord
  validates :menu, presence: true

  belongs_to :customer
end
