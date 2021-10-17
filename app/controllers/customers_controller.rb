# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer, except: %i[new create get_all_customer_data]
  before_action :check_valid_token, unless: :devise_controller?, except: %i[new create get_all_customer_data]

  def index; end

  def new; end

  def create
    if !params[:customer][:exist_cust_id].nil? && params[:customer][:exist_cust_id] != ''
      @customer = Customer.find(params[:customer][:exist_cust_id])
      @customer.update(customer_params)
    else
      @customer = Customer.create!(customer_params)
    end
    LinkedCustomer.find_or_create_by(customer: @customer, user: current_user, company_id: (params[:customer][:company_id].empty? ? @customer.id : current_user.current_company_id), delist: false)
    current_user.update(current_company_id: (params[:customer][:company_id].empty? ? @customer.id : current_user.current_company_id))
    if !params[:customer][:create_data].nil? && params[:customer][:create_data] != ''
      flash[:notice] = 'Customer Created Successfully..!'
      redirect_to add_customer_path(current_user.token)
    elsif !params[:customer][:update_data].nil? && params[:customer][:update_data] != ''
      flash[:notice] = 'Company Details Updated Successfully..!'
      redirect_to company_profile_path(current_user.token)
    else
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
  end

  def show_customers
    @all_customers = current_user.customers.where.not(id: current_user.current_company_id)
  end

  def new_customer; end

  def edit_customer
    @customer_details = Customer.find(params[:customer_id])
    render partial: 'edit_customer'
  end

  def update_customer
    @customer_details = Customer.find(params[:customer_id])
    @customer_details.update(customer_params)

    if params[:req_from]
      render plain: (customer_params[:delist].to_i == 1 ? 0 : 1)
    else
      flash[:notice] = 'Customer Updated Successfully..!'
      redirect_to manage_customers_path
    end

  end

  def get_all_customer_data
    customer_name = Customer.arel_table[:customer_name]
    @all_customers = Customer.where(customer_name.matches("%#{params[:search_term]}%")).where.not(id: current_user.current_company_id).map do |customer|
      { value: customer.id, label: customer.customer_name, phone: customer.customer_phone, email: customer.customer_email, address: customer.customer_address }
    end
    respond_to do |format|
      format.html
      format.json { render json: @all_customers }
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:customer_name, :customer_phone, :customer_email, :customer_address, :customer_logo, :delist)
  end
end