# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer
  before_action :check_valid_token, unless: :devise_controller?, except: [:check_user_home]

  def check_user_home
    case current_user.read_attribute_before_type_cast(:role)
    when 0
      redirect_to super_admin_home_path(current_user.token)
    when 1
      redirect_to admin_home_path(current_user.token)
    when 2
      redirect_to employee_home_path(current_user.token)
    when 3
      redirect_to customer_home_path(current_user.token)
    end
  end

  def super_admin_index; end

  def index
    @all_complaints = current_user.read_attribute_before_type_cast(:role) ? current_user.customer.compliants : current_user.customer.compliants.where(user_id: current_user.id)
    @all_products = LinkedProduct.where(company_id: current_user.customer.id).collect(&:product)
  end
end
