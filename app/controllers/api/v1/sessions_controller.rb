class Api::V1::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/vnd.ynr.v1' }
 
  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :json => {:info => "Logged in", :user => current_user}, :status => 200
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_out(resource_name)
    render :json => {:info => "Logged out"}, :status => 200
  end

  def failure
    render :json => {:error => "Invalid email or password"}, :status => 401
  end
end
