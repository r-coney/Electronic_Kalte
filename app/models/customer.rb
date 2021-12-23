class Customer < ApplicationRecord
  enum gender:
  {
    man: 0,
    woman: 1
  }
   validates :name, presence: true
   validates :birthday, presence: true
   validates :address, presence: true
   validates :phone, presence: true
   validates :gender, presence: true
end
