class Category < ApplicationRecord
  has_many :sub_categories
  has_many :sub_categories, class_name: :Category, foreign_key: :category_id, dependent: :destroy
  belongs_to :category, class_name: :Category, optional: true
  has_many :product
  scope :categories, lambda {where(category_id: nil)}
end
