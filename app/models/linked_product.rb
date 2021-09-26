class LinkedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :customer
  has_many :compliants
end
