class Product < ApplicationRecord
  has_many :linked_products
  has_many :customers, through: :linked_products
  has_many :compliants
  belongs_to :category
end