class User < ApplicationRecord
  attr_accessor :mobile_or_email
  before_create :generate_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_picture
  has_many :password_histroies
  has_many :linked_customers
  has_many :customers, through: :linked_customers
  has_many :compliants

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    mobile_or_email = conditions.delete(:mobile_or_email)
    where(conditions).where(
      ["contact_number = :value OR email = :value",{ value: mobile_or_email.strip.downcase}]).first
  end

  protected
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
  end
end
