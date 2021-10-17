# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  layout :determine_layout

  private

  def determine_layout
    module_name = self.class.to_s.split("::").first
    return (['Devise', 'Users'].include?(module_name) ? "devise" : "application")
  end

  def check_linked_customer
    if current_user.active != true
      render file: 'public/account_deactivation.html', layout: false
    else
      redirect_to company_details_path(current_user.token) if current_user.customers.size.zero?
    end
  end

  def check_valid_token
    if params[:token]
      render file: 'public/422.html', layout: false unless current_user.token == params[:token]
    else
      redirect_to root_path
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
