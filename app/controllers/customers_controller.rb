class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer, except: [:index, :new, :create]
  
  def index
    customer_name = Customer.arel_table[:customer_name]
    @all_customers = Customer.where(customer_name.matches("%#{params[:search_term]}%")).map{|customer| {value: customer.id, label:customer.customer_name, phone:customer.customer_phone, email:customer.customer_email, address:customer.customer_address}}
    respond_to do |format|
      format.html
      format.json {render json: @all_customers}
    end
  end

  def new
    @customer = Customer.new
  end

  def create
    @create_or_update = nil
    @customer = Customer.find(params[:customer][:exist_cust_id])
    if params[:customer][:exist_cust_id] != ''
      @customer = Customer.find(params[:customer][:exist_cust_id])
      @customer.update(customer_params)
      @create_or_update = true
    else
      @customer = Customer.new(customer_params)
      @customer.save
      @create_or_update = true
    end

    if @create_or_update
      LinkedCustomer.find_or_create_by(customer: @customer, user: current_user, delist: false)
      redirect_to root_path
    else
      render :new
    end
  end

  def show

  end

  private

  def customer_params
    params.require(:customer).permit(:customer_name, :customer_phone, :customer_email, :customer_address, :customer_logo)
  end
end
