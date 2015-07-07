class Api::V1::UsersController < Api::V1::BaseController
  before_filter :authenticate_user!, :except => [:create, :show]
  respond_to :html, :json

  def show
    if current_user
      render :json => {:info => "Current User", :user => current_user }, :status => 200
    else
      render :json => {}, :status => 401
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      sign_in(@user)
      render :json => {:info => "Current User", :user => @user }, :status => 200
    else
      render :json => {:errors => @user.errors}, :status => 401
    end
  end

  def update
    @user = User.update(current_user.id, user_params)
    if @user.valid?
      render :json => {:info => "Current User", :user => @user }, :status => 200
    else
      render :json => {:errors => @user.errors}, :status => 401
    end
  end

  def destroy
    respond_with :api, User.find(current_user.id).destroy
  end

  private

    def user_params
      params.require(:user).permit(:account_type, :email, :password, :password_confirmation, :avatar, :avatar_image_url)
    end
end
