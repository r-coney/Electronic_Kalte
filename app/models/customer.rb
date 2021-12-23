class Customer < ApplicationRecord
  enum gender:
  {
    man: 0,
    woman: 1
  }
   validates :name, presence: true, length: { maximum: 50 }
   validates :birthday, presence: true
   validates :address, presence: true, length: { maximum: 50 }
   validates :phone, presence: true, length: { maximum: 15 }
   validates :gender, presence: true
end
