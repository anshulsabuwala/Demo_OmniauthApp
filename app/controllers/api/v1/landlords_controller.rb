class Api::V1::LandlordsController < Api::V1::BaseController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json

  def index
    respond_with :api, Landlord.all
  end

  def show
    landlord = Landlord.find(params[:id])
    respond_with :api, landlord.to_json({:include => [:user]})
  end

  def create
    if current_user.role_id == nil
      @landlord = Landlord.new(landlord_params)
      @landlord.user = current_user
      @landlord.user_id = current_user.id
      if @landlord.save
        render :json => @landlord, :status => 200
      else
        render :json => {:errors => @landlord.errors}, :status => 401
      end
    else
      render :json => {:error => 'User already has a profile'}, :status => 401
    end
  end

  def update
    if current_user.role_type == 'Landlord'
      respond_with :api, Landlord.update(current_user.role_id, landlord_params)
    else
      render :json => {:error => 'User is not a landlord'}, :status => 401
    end
  end

  def destroy
    if current_user.role_type == 'Landlord'
      @landlord = Landlord.find(current_user.role_id)
      @landlord.user.role = nil
      @landlord.user.save
      respond_with :api, @landlord.destroy
    else
      render :json => {:error => 'User is not a landlord'}, :status => 401
    end
  end

  private
    def landlord_params
      params.require(:landlord).permit(:title, :full_name, :gender, :date_of_birth, :address_type, :address, :city, :postal_code, :country, :occupation, :brief_description, :verify_properties)
    end

end
