class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	skip_before_filter :authenticate_user!
	def all
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    if params[:user_type].present?
      session[:user_type] = params[:user_type]
    else
      user_type = {}
      user_type = request.env['omniauth.params']
      session[:user_type] = request.env['omniauth.params']["user_type"]
    end
    @user = User.from_omniauth(request.env["omniauth.auth"], current_user, session[:user_type])
    if @user.persisted?
      sign_in @user, :event => :authentication
      session[:user_type] = nil
      redirect_to '#/dashboard'
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
    end
	end

	  def failure
      #handle you logic here..
      #and delegate to super.
      super
   end


	alias_method :facebook, :all
	alias_method :twitter, :all
	alias_method :google_oauth2, :all
end
