# frozen_string_literal: true

class PasswordHistroy < ApplicationRecord
  self.table_name = 'password_histroies'
  belongs_to :user
end
