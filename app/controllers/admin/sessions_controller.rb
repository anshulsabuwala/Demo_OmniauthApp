class Admin::SessionsController < Devise::SessionsController
  layout 'admindevise'
  
  def create
    admin = Admin.find_by_email(params[:admin][:email])
    if !admin.nil? 
      super
    else
      redirect_to admin_root_url
    end
  end

  def destroy 
    puts super

  end


  private 

  def after_sign_out_path_for(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    home_path = :"#{scope}_root_path"
    respond_to?(home_path, true) ? send(home_path) :  new_admin_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    home_path = :"#{scope}_root_path"
    respond_to?(admin_root_path, true) ? send(admin_root_path) : admin_root_path
  end
end