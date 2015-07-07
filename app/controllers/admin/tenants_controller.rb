class Admin::TenantsController < Admin::AdminController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy]

  def index
    @tenants = Tenant.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @tenant = Tenant.new
    @user = @tenant.build_user
  end

  def edit
  end

  def create
    @tenant = Tenant.new(tenant_params)
    respond_to do |format|
      if @tenant.save
        user = User.find_by_role_id(@tenant.id)
        @tenant.user_id = user.id
        @tenant.save
        format.html { redirect_to admin_tenants_url, notice: 'Tenant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tenant }
      else
        format.html { render action: 'new' }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to admin_tenants_url, notice: 'Tenant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(@tenant.user_id)
    @user.destroy
    @tenant.destroy
    respond_to do |format|
      format.html { redirect_to admin_tenants_url }
      format.json { head :no_content }
    end
  end

  def home
  end  

  private
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    def tenant_params
      params.require(:tenant).permit(:title, :full_name, :gender, :date_of_birth, :address_type, :address, :city, :postal_code, :country, :occupation, :brief_description, :user_attributes => [:id, :email, :username, :password, :password_confirmation, :avatar, :avatar_image_url, :account_type])
    end
end
