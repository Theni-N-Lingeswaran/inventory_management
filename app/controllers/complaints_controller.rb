# frozen_string_literal: true

class ComplaintsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer, except: []
  before_action :check_valid_token, unless: :devise_controller?, except: []

  def index
    @all_complaints = current_user.read_attribute_before_type_cast(:role) ? current_user.customer.compliants : current_user.customer.compliants.where(user_id: current_user.id)
  end

  def new_product
    @all_customers_array = []
    @all_customers = Customer.all
    @all_customers.map { |cust| @all_customers_array << { label: cust.customer_name, value: cust.id } }
    @main_category_array = []
    @main_categories = Category.main_categories
    @main_categories.map { |category| @main_category_array << { label: category.category_name, value: category.id } }
  end

  def create_product
    @product = Product.create!(product_params)
    if @product
      LinkedProduct.create!(product: @product, customer_id: params[:product][:customer_id], user_id: current_user.id, company_id: current_user.current_company_id)
      flash[:notice] = 'Product Created Successfully..!'
    else
      flash[:notice] = 'Problem with product creation..!'
    end
    redirect_to new_product_path
  end

  def show_products
    @all_products = LinkedProduct.where(company_id: current_user.customer.id).collect(&:product)
  end

  def edit_product
    @edit_product = Product.find(params[:product_id])
    @all_customers_array = []
    @all_customers = Customer.all
    @all_customers.map { |cust| @all_customers_array << { label: cust.customer_name, value: cust.id } }
    @main_category_array = []
    @main_categories = Category.main_categories
    @main_categories.map { |category| @main_category_array << { label: category.category_name, value: category.id } }
    @sub_category_array = []
    @sub_categories = Category.find(@edit_product&.category&.category&.id).sub_categories
    @sub_categories.map { |category| @sub_category_array << { label: category.category_name, value: category.id } }
    render partial: 'edit_product'
  end

  def update_product
    @product_details = Product.find(params[:product_id])
    @product_details.update(product_params)

    if params[:req_from]
      render plain: (product_params[:delist].to_i == 1 ? 0 : 1)
    else
      if params[:linked_customer_ids] != nil && params[:linked_customer_ids] != ''
        params[:linked_customer_ids].split(',').map(&:to_i).each do |linked_cust_product|
          @exist_or_new = LinkedProduct.find_or_create_by(product: @product_details, customer_id: linked_cust_product, user_id: current_user.id, company_id: current_user.current_company_id)
          @exist_or_new.update(delist: false)
        end
        @delist_customers = LinkedProduct.where(product: @product_details, company_id: current_user.current_company_id).where.not(customer_id: params[:linked_customer_ids].split(',').map(&:to_i))
        unless @delist_customers.size.zero?
          @delist_customers.update_all(delist: true)
        end
      end
      flash[:notice] = 'Product Updated Successfully..!'
      redirect_to manage_products_path
    end
  end

  def new
    @all_customers_array = []
    @all_customers = Customer.all
    @all_customers.map { |cust| @all_customers_array << { label: cust.customer_name, value: cust.id } }
  end

  def create
    @complaint = Compliant.create!(complaints_params)
    flash[:notice] = @complaint ? 'Complaint Created Successfully..!' : 'Problem with complaint creation..!'
    redirect_to new_complaint_path
  end

  def edit_complaint
    @complaint_details = Compliant.find(params[:complaint_id])
    @all_customers_array = []
    @all_customers = Customer.all
    @all_customers.map { |cust| @all_customers_array << { label: cust.customer_name, value: cust.id } }
    render partial: 'edit_complaint'
  end

  def update_complaint
    @complaint_details = Compliant.find(params[:complaint_id])
    @complaint_details.update(complaints_params)
    if params[:req_from]
      render plain: (complaints_params[:delist].to_i == 1 ? 0 : 1)
    else
      flash[:notice] = 'Complaint Updated Successfully..!'
      redirect_to manage_complaints_path
    end
  end

  def get_customers_products
    @all_customer_product_array = []
    @customer_detail = Customer.find(params[:customer_id])
    @customer_detail.products.map { |prod| @all_customer_product_array << { label: "#{prod.product_name} - #{prod.product_code}", value: prod.id } }
    render json: @all_customer_product_array
  end

  private

  def complaints_params
    params.require(:complaint).permit(:user_id, :company_id, :customer_id, :product_id, :complaint_details, :remarks, :estimation_date, :total_amount, :status, :delist)
  end

  def product_params
    params.require(:product).permit(:product_name, :product_code, :product_detail, :category_id, :delist)
  end
end
