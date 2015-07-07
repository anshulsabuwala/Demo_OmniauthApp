class Admin::ManagersController < Admin::AdminController
  before_action :set_manager, only: [:show, :edit, :update, :destroy]

  def index
    @managers = Manager.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @manager = Manager.new
    @user = @manager.build_user
  end

  def edit
  end

  def create
    @manager = Manager.new(manager_params)
    respond_to do |format|
      if @manager.save
        user = User.find_by_role_id(@manager.id)
        @manager.user_id = user.id
        @manager.save
        format.html { redirect_to admin_managers_url, notice: 'Manager was successfully created.' }
        format.json { render action: 'show', status: :created, location: @manager }
      else
        format.html { render action: 'new' }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manager.update(manager_params)
        format.html { redirect_to admin_managers_url, notice: 'Manager was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(@manager.user_id)
    @user.destroy
    @manager.destroy
    respond_to do |format|
      format.html { redirect_to admin_managers_url }
      format.json { head :no_content }
    end
  end

  def home
  end  

  private
    def set_manager
      @manager = Manager.find(params[:id])
    end

    def manager_params
      params.require(:manager).permit(:company_name, :company_description, :phone_number, :verify_properties, :estate_agent,
                                      :contact_person_full_name, :contact_person_email_address,:contact_person_position, :contact_person_photo, :contact_person_image_url,
                                      :street, :city, :postal_code, :state, :country, :occupation, :page_url, :contact_person_phone_number, :contact_person_occupation,
                                      :user_attributes => [:id, :email, :username, :password, :password_confirmation, :avatar, :avatar_image_url, :account_type])
    end
end
