require 'api_constraints'

YourNextRoom::Application.routes.draw do
  #devise_for :admins
  devise_for :admins, controllers: { sessions: "admin/sessions" }
	namespace :admin do
		root 'home#index'
    #devise_for :admins  
		resources :tenants
		resources :landlords
		resources :managers
		resources :users
    resources :admin_users
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      devise_scope :user do
        match '/sessions' => 'sessions#create', :via => :post
        match '/sessions' => 'sessions#destroy', :via => :delete

        match '/confirmations' => 'confirmations#create', :via => :post
        match '/confirmations' => 'confirmations#show', :via => :get

        match '/passwords' => 'passwords#create', :via => :post
        match '/passwords' => 'passwords#update', :via => :put

        match '/update_password' => 'passwords#update_password', :via => :put

      end
      resources :users, only: [:create]
      match '/users' => 'users#show', :via => :get
      match '/users' => 'users#update', :via => :put
      match '/users' => 'users#destroy', :via => :delete

      resources :tenants
      match '/tenants' => 'tenants#update', :via => :put
      match '/tenants' => 'tenants#destroy', :via => :delete

      resources :landlords
      match '/landlords' => 'landlords#update', :via => :put
      match '/landlords' => 'landlords#destroy', :via => :delete

      resources :managers
      match '/managers' => 'managers#update', :via => :put
      match '/managers' => 'managers#destroy', :via => :delete
    end
  end
end
