Rails.application.routes.draw do

  namespace :admins do
    resources :messages
  end
  namespace :admins do
    resources :offices
  end
  namespace :admins do
    resources :posts
  end
  #get 'omniauth/facebook/callback' => 'admins/socials#callback'
  namespace :users do
    resources :contacts
  end
  namespace :admins do
    resources :socials, only: [:index] do
      collection do 
         get :connect
         get :callback
      end
    end
    resources :zips
    resources :campaigns
    resources :users
    resources :states do
      collection {post :import}
    end
    resources :politicians do
      collection {post :import}
    end
    resources :area_codes do
      collection {post :import}
    end
    resources :elections
    resources :election_results do
      collection {post :import}
    end
    resources :districts do
      collection {post :import}
    end
  end
  devise_for :users, controllers: { registrations: 'users/registrations'}
  devise_scope :user do
    get "/omniauth/facebook/callback" => "users/omniauth_callbacks#facebook"
  end
  devise_for :admins, :controllers => { :registrations => 'admins/registrations'}
  as :admin do
    # Define routes for Admin within this block.
  end
  #get 'users/politicians'
  get 'admins/welcome/index'
  root 'users/politicians#index'

  namespace :users do
    resources :politicians
  end

  namespace :api do
    namespace :v1 do
      resources :states, only: [:index]
      resources :area_codes, only: [:index]
      resources :elections, only: [:index]
      resources :campaigns,only: [:index]
      resources :politicians do
        collection do
          get :autocomplete
          get :search
        end
      end 
      resources :stores, only: [:index]
      resources :offices, only: [:index]
      resources :posts, only: [:index]
      resources :settings, only: [:index]
      resources :messages, only: [:create]
      #resources :contacts, only: [:index, :new, :all]
      resources :contacts do
        collection do
          post :all
          get :check
          get :details
          post :test
        end
      end
      resources :districts do
        collection do 
          get :find
          get :test
        end
        member do
          get :show
        end
      end
      mount_devise_token_auth_for 'User', at: 'auth'
      mount_devise_token_auth_for 'Admin', at: 'admin_auth', :skip => [:registrations]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
