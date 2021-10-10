class SettingsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_linked_customer, except: [:link_customer]
	before_action :check_valid_token, unless: :devise_controller?
	
	def index
	end

	def user_profile
	end

	def update_user_profile
		current_user.update(user_profile_params)
		flash[:notice] = 'Details Updated Successfully..!'
		redirect_to user_details_path
	end

	def company_profile
	end

	def link_customer
	end

	def show_users
	end

	def show_invoices
	end

	def get_sub_categories
		@sub_category_array = []
		@sub_categories = Category.where(category_id: params[:category_id])
    @sub_categories.map{|sub_category| @sub_category_array << { label: sub_category.category_name, value: sub_category.id }}
    respond_to do |format|
      format.html {render partial: 'get_sub_categories'}
      format.json {render json: @sub_category_array}
    end
	end

	def show_categories
	end

	def update_category_status
		@category_details = Category.find(params[:category_id])
    @category_details.update(delist: params[:delist_status])
    if @category_details&.sub_categories&.size != 0
    	@category_details.sub_categories.update_all(delist: params[:delist_status])
    end
    render plain: (params[:delist_status].to_i == 1 ? 0 : 1)
	end

	private

  def user_profile_params
    params.require(:user).permit(:contact_name, :contact_number, :email, :profile_picture)
  end
end
