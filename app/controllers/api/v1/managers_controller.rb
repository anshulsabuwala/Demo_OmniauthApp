class Api::V1::ManagersController < Api::V1::BaseController

  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :json

  def index
    respond_with :api, Manager.all
  end

  def show
    manager = Manager.find(params[:id])
    respond_with :api, manager.to_json({:include => [:user]})
  end

  def create
    if current_user.role_id == nil
      @manager = Manager.new(manager_params)
      @manager.user = current_user
      @manager.user_id = current_user.id
      if @manager.save
        render :json => @manager, :status => 200
      else
        render :json => {:errors => @manager.errors}, :status => 401
      end
    else
      render :json => {:error => 'User already has a profile'}, :status => 401
    end
  end

  def update
    if current_user.role_type == 'Manager'
      @manager = Manager.update(current_user.role_id, manager_params)
      render :json => @manager, :status => 200
    else
      render :json => {:error => 'User is not a manager'}, :status => 401
    end
  end

  def destroy
    if current_user.role_type == 'Manager'
      @manager = Manager.find(current_user.role_id)
      @manager.user.role = nil
      @manager.user.save
      respond_with :api, @manager.destroy
    else
      render :json => {:error => 'User is not a manager'}, :status => 401
    end
  end

  private
    def manager_params
      params.require(:manager).permit(:company_name, :company_description, :phone_number, :verify_properties, :estate_agent, :contact_person_full_name, :contact_person_email_address, :contact_person_position, :contact_person_image_url)
    end

end
