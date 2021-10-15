# frozen_string_literal: true

class LinkedCustomer < ApplicationRecord
  default_scope { where(delist: false) }
  belongs_to :customer
  belongs_to :user
end
