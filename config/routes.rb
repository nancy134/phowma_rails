Rails.application.routes.draw do

  get 'omniauth/facebook/callback' => 'admins/socials#callback'
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
  devise_for :admins, :controllers => { :registrations => 'admins/registrations'}
  as :admin do
    # Define routes for Admin within this block.
  end
  get 'users/welcome/index'
  get 'admins/welcome/index'
  root 'users/welcome#index'

  namespace :api do
    namespace :v1 do
      resources :states, only: [:index]
      resources :area_codes, only: [:index]
      resources :elections, only: [:index]
      resources :politicians, only: [:index]
      resources :stores, only: [:index]
      resources :settings, only: [:index]
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
      end
      mount_devise_token_auth_for 'User', at: 'auth'
      mount_devise_token_auth_for 'Admin', at: 'admin_auth', :skip => [:registrations]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
