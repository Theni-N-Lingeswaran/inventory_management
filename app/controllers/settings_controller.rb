# frozen_string_literal: true
require "prawn"

class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_linked_customer, except: [:link_customer]
  before_action :check_valid_token, unless: :devise_controller?

  def index; end

  def user_profile; end

  def update_user_profile
    current_user.update(user_profile_params)
    flash[:notice] = 'Details Updated Successfully..!'
    redirect_to user_details_path
  end

  def company_profile; end

  def link_customer; end

  def show_users
    @all_employees = current_user.customer.users.where.not(id: current_user.id)
  end

  def new_employee; end

  def create_employee
    @employee_details = User.create!(employee_params)
    if @employee_details
      LinkedCustomer.create!(customer: current_user.customer, user: @employee_details, company_id: current_user.current_company_id)
      PasswordHistroy.create!(raw_password: employee_params[:password], user: @employee_details)
      flash[:notice] = 'Employee Created Successfully..!'
    else
      flash[:notice] = 'Problem with Employee Creation'
    end
    redirect_to new_employee_path
  end

  def edit_employee
    @employee_details = User.find(params[:employee_id])
    render partial: 'edit_employee'
  end

  def update_employee
    @employee_details = User.find(params[:employee_id])
    @employee_details.update(employee_params)

    if params[:req_from]
      render plain: (employee_params[:active].to_i == 1 ? 0 : 1)
    else
      flash[:notice] = 'Employee Updated Successfully..!'
      redirect_to manage_users_path
    end
  end

  def new_categories
    @main_category_array = []
    @main_categories = Category.main_categories.where(company_id: current_user.customer.id)
    @main_categories.map { |category| @main_category_array << { label: category.category_name, value: category.id } }
    render partial: 'new_categories'
  end

  def create_categories
    @category = Category.create!(category_params)
    if @category
      if category_params[:category_id] != nil
        parent_delist_status = Category.find(category_params[:category_id]).delist
        @category.update(delist: parent_delist_status)
      end
      
      flash[:notice] = category_params[:category_id] != nil ? 'Sub Category Created Successfully..!' : 'Main Category Created Successfully..!'
    else
      flash[:notice] = category_params[:category_id] != nil ? 'Problem with Sub Category Creation..!' : 'Problem with Main Category Creation..!'
    end
    redirect_to manage_categories_path(current_user.token, !category_params[:category_id].nil? ? category_params[:category_id] : @category.id)
  end

  def show_categories
    if params[:category_id] != nil
      @main_category_id = params[:category_id]
      @sub_categories = Category.find(params[:category_id]).sub_categories
    else
      @main_category_id = Category.main_categories.where(company_id: current_user.customer.id)&.first&.id
      @sub_categories = Category.main_categories.where(company_id: current_user.customer.id)&.first&.sub_categories
    end
  end

  def edit_categories
    @category_details = Category.find(params[:category_id])
    @main_category_id = @category_details.category_id
    @main_category_array = []
    @main_categories = Category.main_categories
    @main_categories.map { |category| @main_category_array << { label: category.category_name, value: category.id } }
    render partial: 'edit_categories'
  end

  def update_categories
    @category_details = Category.find(params[:category_id])
    @category_details.update(category_params)
    if @category_details&.sub_categories&.size != 0 && category_params[:delist].to_i == 1
      @category_details.sub_categories.update_all(delist: category_params[:delist])
    end
    if params[:req_from]
      render plain: (category_params[:delist].to_i == 1 ? 0 : 1)
    else
      flash[:notice] = 'Category Updated Successfully..!'
      redirect_to manage_categories_path(current_user.token, (category_params[:category_id] != nil ? category_params[:category_id] : params[:category_id]))
    end
  end

  def get_sub_categories
    @main_category_id = params[:category_id]
    @sub_category_array = []
    @sub_categories = Category.where(category_id: params[:category_id])
    @sub_categories.map do |sub_category|
      @sub_category_array << { label: sub_category.category_name, value: sub_category.id }
    end

    respond_to do |format|
      format.html { render partial: 'get_sub_categories' }
      format.json { render json: @sub_category_array }
    end
  end

  def show_invoices; end

  def generate_invoice
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "sample invoice download"
        send_data pdf.render, filename: 'invoice.pdf', type: 'application/pdf'
      end
    end
  end

  private

  def user_profile_params
    params.require(:user).permit(:contact_name, :contact_number, :email, :profile_picture)
  end

  def category_params
    params.require(:category).permit(:category_name, :category_id, :company_id, :delist)
  end

  def employee_params
    params.require(:user).permit(:contact_name, :contact_number, :alternate_contact_number, :email, :password, :password_confirmation, :current_company_id, :role, :active)
  end
end
