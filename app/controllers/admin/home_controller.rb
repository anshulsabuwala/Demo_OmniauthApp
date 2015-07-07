class Admin::HomeController < Admin::AdminController
  before_action :authenticate_admin!
  #layout 'admindevise'

  def index
		@total_tenants_count = Tenant.count(:all)
		@total_landlords_count = Landlord.count(:all)
		@total_managers_count = Manager.count(:all) 
  end
  
end