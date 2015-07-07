class AuthorizationsController < ApplicationController 
  respond_to :json
  before_filter :require_authentication, :only => :destroy

  def create
    if params[:provider] == 'facebook'
      session[:oauth] = Koala::Facebook::OAuth.new(params[:clientId], 'dfdd6086905fa30d30bda3c396ab20a0', 'http://localhost:3000' + '/')
      if params[:code].present?
        session[:access_token] = session[:oauth].get_access_token(params[:code])
      end
		  @api = Koala::Facebook::API.new(session[:access_token])
	    @graph_data = @api.get_object("me?fields=name,picture,email")
      session[:user_detail] = @graph_data
      if @graph_data.present?
        @user = User.find_for_facebook_oauth(@graph_data, params[:provider], params[:clientId])      
        if @user.present?     
          render :json => { token: session[:access_token] }
        else
          redirect_to new_user_registration_url
        end
      end
    elsif params[:provider] == 'twitter'

    elsif params[:provider] == 'google'
      if params[:code].present?
        @user_tokens = get_tokens(params[:code])
        #return render :text => @user_tokens.inspect
      end
      #user_info = call_api('/oauth2/v2/userinfo', @user_tokens['access_token'])
      render :json => { token: @user_tokens }
    elsif params[:provider] == 'linkedin'
      oauth = LinkedIn::OAuth2.new('75aw62f678ceqt', 'gtRvDyD8Cp2HeYhZ', 'http://localhost:3000' + '/')
      url = oauth.auth_code_url
      access_token = oauth.get_access_token(params[:code])
      @api_access_token = LinkedIn::API.new(access_token)
      @user_detail = @api_access_token.profile
      if @user_detail.present?
        @user = User.find_for_linkedin_oauth(@user_detail, params[:provider], params[:clientId])      
        if @user.present?
          render :json => { token: @api_access_token}
        else
          redirect_to new_user_registration_url
        end
      end
    else
    
      if params[:email].present?
        registered_user = User.where(:email => params[:email]).first
        if registered_user
          return registered_user
        else
          @user = User.create(:email => params["email"],
                              :password => Devise.friendly_token[0,20])
          render :json => { token: @user } 
        end
      end  

    end
    
  end


  private
  
    def get_tokens(code)
      params['code'] = code
      params['client_id'] = '471490106031-u6p1vkcbet2s8v6s21m7usnlm6797eu8.apps.googleusercontent.com'
      params['client_secret'] = '86kwydDFa0WrfbQG9U0Rl-Hp'
      params['redirect_uri'] = 'http://localhost:3000'
      params['grant_type'] = 'authorization_code'

      # Initialize HTTP library
      url = URI.parse('https://accounts.google.com')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production

      # Make request for tokens    
      request = Net::HTTP::Post.new('/o/oauth2/token')
      request.set_form_data(params)
      response = http.request(request)
      JSON.parse(response.body)
    end


    def call_api(path, access_token)
        # Initialize HTTP library
        url = URI.parse('https://www.googleapis.com')
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production

        # Make request to API
        request = Net::HTTP::Get.new(path)
        request['Authorization'] = 'Bearer ' + access_token
        response = http.request(request)

        JSON.parse(response.body)

    end
end
