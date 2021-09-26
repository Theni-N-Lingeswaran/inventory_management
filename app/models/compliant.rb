class Compliant < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :invoices
  enum status: {pending: 0, processing: 1, resolved: 2, delivered: 3 }, _prefix: true
end
