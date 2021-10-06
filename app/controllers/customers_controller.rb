class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer, except: [:new, :create, :get_all_customer_data]
  before_action :check_valid_token, unless: :devise_controller?, except: [:new, :create, :get_all_customer_data]
  
  def index
    
  end

  def new
    @customer = Customer.new
  end

  def create
    @create_or_update = nil
    if params[:customer][:exist_cust_id] != nil && params[:customer][:exist_cust_id] != ''
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

      if params[:customer][:update_data] != nil && params[:customer][:update_data] != ''
        flash[:notice] = 'Company Details Updated Successfully..!'
        redirect_to company_profile_path(current_user.token)
      else
        if current_user.role == 1
          redirect_to admin_home_path(current_user.token)
        elsif current_user.role == 2
          redirect_to employee_home_path(current_user.token)
        elsif current_user.role == 3
          redirect_to customer_home_path(current_user.token)
        end
      end
    else
      render :new
    end
  end

  def show

  end

  def get_all_customer_data
    customer_name = Customer.arel_table[:customer_name]
    @all_customers = Customer.where(customer_name.matches("%#{params[:search_term]}%")).map{|customer| {value: customer.id, label:customer.customer_name, phone:customer.customer_phone, email:customer.customer_email, address:customer.customer_address}}
    respond_to do |format|
      format.html
      format.json {render json: @all_customers}
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:customer_name, :customer_phone, :customer_email, :customer_address, :customer_logo)
  end
end
