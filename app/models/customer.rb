class Customer < ApplicationRecord
  enum gender:
  {
    man: 0,
    woman: 1
  }
   validates :name, presence: true, length: { maximum: 50 }

   VALID_BERTHDAY_REGEX = /\A\d{4}-\d{2}-\d{2}\z/

   validates :birthday, presence: true, length: { maximum: 20},
                        format: { with: VALID_BERTHDAY_REGEX }

   validates :address, presence: true, length: { maximum: 50 }

   VALID_PHONE_REGEX = /\A\d{10,11}\z/
   validates :phone, presence: true, length: { maximum: 15 },
                    format: { with: VALID_PHONE_REGEX = /\A\d{10,11}\z/ }

   validates :gender, presence: true
   
   has_many :kaltes
end
