class Customer < ApplicationRecord
  has_one_attached :customer_logo
  has_many :linked_customers
  has_many :users, through: :linked_customers
  has_many :linked_products
  has_many :products, through: :linked_products

  scope :active_customers, lambda {where(:delist=>false)}
  scope :de_active_customers, lambda {where(:delist=>true)}
end
