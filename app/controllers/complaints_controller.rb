class ComplaintsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer, except: []
  before_action :check_valid_token, unless: :devise_controller?, except: []

  def index
    # @all_complaints = Compliant.includes(:product).includes(:invoices).where(product: {delist: false})
    @all_complaints = Compliant.all
  end

  def new
    @all_customers_array = []
    @all_customers = Customer.all
    @all_customers.map{|cust| @all_customers_array << { label: cust.customer_name, value: cust.id }}
  end

  def new_product
    @all_customers_array = []
    @all_customers = Customer.all
    @all_customers.map{|cust| @all_customers_array << { label: cust.customer_name, value: cust.id }}
    @main_category_array = []
    @main_categories = Category.main_categories
    @main_categories.map{|category| @main_category_array << { label: category.category_name, value: category.id }}
  end

  def create
    @complaint = Compliant.create!(complaints_params)
    if @complaint
      flash[:notice] = 'Complaint Created Successfully..!'
    else
      flash[:notice] = 'Problem with complaint creation..!'
    end
    redirect_to new_complaint_path
  end

  def create_product
    @product = Product.create!(product_params)
    if @product
      LinkedProduct.create!(product: @product, customer_id: params[:product][:customer_id], user_id: current_user.id)
      flash[:notice] = 'Product Created Successfully..!'
    else
      flash[:notice] = 'Problem with product creation..!'
    end
    redirect_to new_product_path
  end

  def show_products
    @all_products = Product.all
  end

  def update_product_status
    @product_details = Product.find(params[:product_id])
    @product_details.update(delist: params[:delist_status])
    render plain: (params[:delist_status].to_i == 1 ? 0 : 1)
  end

  def update_complaint_status
    @complaint_details = Compliant.find(params[:complaint_id])
    @complaint_details.update(delist: params[:delist_status])
    render plain: (params[:delist_status].to_i == 1 ? 0 : 1)
  end

  def get_customers_products
    @all_customer_product_array = []
    @customer_detail = Customer.find(params[:customer_id])
    @customer_detail.products.map{|prod| @all_customer_product_array << { label: prod.product_name, value: prod.id }}
    render json: @all_customer_product_array
  end

  def show_customers
  end

  private

  def complaints_params
    params.require(:complaint).permit(:user_id, :customer_id, :product_id, :complaint_details, :remarks, :estimation_date, :total_amount, :status)
  end

  def product_params
    params.require(:product).permit(:product_name, :product_code, :product_detail, :category_id)
  end
end
