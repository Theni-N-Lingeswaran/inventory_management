# frozen_string_literal: true

class Customer < ApplicationRecord
  has_one_attached :customer_logo
  has_many :linked_customers
  has_many :users, through: :linked_customers
  has_many :linked_products
  has_many :products, through: :linked_products
  has_many :compliants
  has_many :compliants, foreign_key: :company_id

  scope :active_customers, -> { where(delist: false) }
  scope :de_active_customers, -> { where(delist: true) }
end
