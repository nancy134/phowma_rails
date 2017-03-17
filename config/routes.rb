Rails.application.routes.draw do
  namespace :admins do
    resources :politicians
  end
  namespace :admins do
    resources :states do
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
      mount_devise_token_auth_for 'User', at: 'auth'
      mount_devise_token_auth_for 'Admin', at: 'admin_auth', :skip => [:registrations]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
