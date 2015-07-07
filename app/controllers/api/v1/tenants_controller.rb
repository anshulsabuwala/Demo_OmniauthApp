class Api::V1::TenantsController < Api::V1::BaseController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json

  def index
    respond_with :api, Tenant.all
  end

  def show
    tenant = Tenant.find(params[:id])
    respond_with :api, tenant.to_json({:include => [:user]})
  end

  def create
    if current_user.role_id == nil
      @tenant = Tenant.new(tenant_params)
      @tenant.user = current_user
      @tenant.user_id = current_user.id
      if @tenant.save
        render :json => @tenant, :status => 200
      else
        render :json => {:errors => @tenant.errors}, :status => 401
      end
    else
      render :json => {:error => 'User already has a profile'}, :status => 401
    end
  end

  def update
    if current_user.role_type == 'Tenant'
      respond_with :api, Tenant.update(current_user.role_id, tenant_params)
    else
      render :json => {:error => 'User is not a tenant'}, :status => 401
    end
  end

  def destroy
    if current_user.role_type == 'Tenant'
      @tenant = Tenant.find(current_user.role_id)
      @tenant.user.role = nil
      @tenant.user.save
      respond_with :api, @tenant.destroy
    else
      render :json => {:error => 'User is not a tenant'}, :status => 401
    end
  end

  private
    def tenant_params
      params.require(:tenant).permit(:title, :full_name, :gender, :date_of_birth, :address_type, :address, :city, :postal_code, :country, :occupation, :brief_description, :verify_properties)
    end

end
