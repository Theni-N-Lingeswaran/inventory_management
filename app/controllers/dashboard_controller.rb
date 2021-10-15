# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer
  before_action :check_valid_token, unless: :devise_controller?, except: [:check_user_home]

  def index
    @all_complaints = current_user.role == 1 ? current_user.customer.compliants : current_user.customer.where(user_id: current_user.id).compliants
    @all_products = LinkedProduct.where(company_id: current_user.customer.id).collect(&:product)
  end

  def check_user_home
    case current_user.role
    when 1
      redirect_to admin_home_path(current_user.token)
    when 2
      redirect_to employee_home_path(current_user.token)
    when 3
      redirect_to customer_home_path(current_user.token)
    end
  end
end
