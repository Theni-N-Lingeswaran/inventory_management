class ComplaintsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer, except: []
  before_action :check_valid_token, unless: :devise_controller?, except: []

  def index
    @all_complaints = Compliant.all
  end

  def show_products
    @all_products = Product.all
  end
end
