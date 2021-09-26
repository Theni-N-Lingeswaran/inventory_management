class SettingsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_linked_customer, except: [:link_customer]
	
	def index
	end

	def user_profile
	end

	def link_customer
	end
end
