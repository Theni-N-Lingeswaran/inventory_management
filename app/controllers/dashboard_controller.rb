class DashboardController < ApplicationController
  before_action :authenticate_user!, :check_linked_customer
  
  def index
    @all_compliants = Compliant.all
    @all_compliants.each do |all_compliant|
    end
  end
end