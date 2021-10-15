# frozen_string_literal: true

class LinkedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :customer
  has_many :compliants
  default_scope { where(delist: false) }
end
