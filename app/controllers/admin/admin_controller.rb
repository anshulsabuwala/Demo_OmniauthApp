class Admin::AdminController < ActionController::Base

	#before_action :authenticate_admin!
	layout 'admin'	

	def index
	end

end
