class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

 private
  def create_remember_token
 self.remember_token = User.digest(User.new_remember_token)
  end
 
end
