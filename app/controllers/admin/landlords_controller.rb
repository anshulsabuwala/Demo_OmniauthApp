class Admin::LandlordsController < Admin::AdminController
  before_action :set_landlord, only: [:show, :edit, :update, :destroy]

  def index
    @landlords = Landlord.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @landlord = Landlord.new
    @user = @landlord.build_user
  end

  def edit
  end

  def create
    @landlord = Landlord.new(landlord_params)
    respond_to do |format|
      if @landlord.save
        user = User.find_by_role_id(@landlord.id)
        @landlord.user_id = user.id
        @landlord.save
        format.html { redirect_to admin_landlords_url, notice: 'Landlord was successfully created.' }
        format.json { render action: 'show', status: :created, location: @landlord }
      else
        format.html { render action: 'new' }
        format.json { render json: @landlord.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @landlord.update(landlord_params)
        format.html { redirect_to admin_landlords_url, notice: 'Landlord was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @landlord.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      @user = User.find(@landlord.user_id)
      @user.destroy
      @landlord.destroy
      respond_to do |format|
        format.html { redirect_to admin_landlords_url }
        format.json { head :no_content }
      end
  end

  private
    def set_landlord
      @landlord = Landlord.find(params[:id])
    end

    def landlord_params
      params.require(:landlord).permit(:title, :full_name, :gender, :date_of_birth, :address_type, :address, :city, :postal_code, :country, :occupation, :brief_description, :user_attributes => [:id, :email, :username, :password, :password_confirmation, :avatar, :avatar_image_url, :account_type])
    end
end
