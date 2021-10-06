class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer
  before_action :check_valid_token, unless: :devise_controller?, except: [:check_user_home]
  
  def index
    if current_user.role == 1
      @all_complaints = Compliant.all
    else
      @all_complaints = Compliant.where(user_id: current_user.id)
    end
    @all_products = Product.all
  end

  def check_user_home
    if current_user.role == 1
      redirect_to admin_home_path(current_user.token)
    elsif current_user.role == 2
      redirect_to employee_home_path(current_user.token)
    elsif current_user.role == 3
      redirect_to customer_home_path(current_user.token)
    end
  end
end