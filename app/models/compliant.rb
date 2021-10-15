# frozen_string_literal: true

class Compliant < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :user
  has_many :invoices
  enum status: { pending: 0, processing: 1, resolved: 2, delivered: 3 }, _prefix: true
  # default_scope { where(delist: false) }
  scope :de_active_complaints, -> { where(delist: true) }
end
