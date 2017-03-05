Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  as :admin do
    # Define routes for Admin within this block.
  end
  get 'welcome/index'
  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      mount_devise_token_auth_for 'Admin', at: 'admin_auth'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
