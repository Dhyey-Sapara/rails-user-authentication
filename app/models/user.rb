class User < ApplicationRecord
  has_secure_password

  before_save :email_downcase

  validates :email, :username, uniqueness: true
  validates :password, confirmation: true, presence: true, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,14}/, message: 'Password should contain atleast one lowercase character, one uppercase character, one number and one special character and it should be between 8 to 14' }

  def secure_remember_token
    SecureRandom.base58(24)
  end

  private

  def email_downcase
    self.email = email.downcase
  end
end
