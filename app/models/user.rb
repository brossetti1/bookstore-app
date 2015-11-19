class User < ActiveRecord::Base
  has_many :addresses
  has_many :orders

  before_create :generate_token

  has_secure_password
  accepts_nested_attributes_for :addresses

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
      format: { with: /\A[A-Z0-9#_-~!$&'()*+,;=:.%]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i}

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(email, password)
    #require 'pry';binding.pry
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end

  def to_param
    token
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
