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

	private

  def user_profile_params
    params.require(:user).permit(:contact_name, :contact_number, :email, :profile_picture)
  end
end
