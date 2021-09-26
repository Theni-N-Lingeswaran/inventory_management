class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?


	private

	def check_linked_customer
		if current_user.customers.size == 0
   		redirect_to company_details_path(current_user.token)
    end
	end
	
  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_in) do |user_params|
	    user_params.permit(:mobile_or_email, :password, :remember_me)
	  end

	  devise_parameter_sanitizer.permit(:sign_up) do |user_params|
	    user_params.permit(:contact_number, :email, :password, :password_confirmation)
	  end
  end
end
