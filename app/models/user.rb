class User < ApplicationRecord
  has_secure_password
  before_save :downcase_email
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
              format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name phone]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private
    def downcase_email
      email.downcase!
    end
end
