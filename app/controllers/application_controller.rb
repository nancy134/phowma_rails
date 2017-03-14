class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: -> {params[:controller].split('/')[0] == 'devise_token_auth'}

  layout :layout_by_resource

  def layout_by_resource
    #Rails.logger.debug "NANCY: params[:controller]: #{params[:controller]}"
    Rails.logger.debug "NANCY: params[0]: #{params[:controller].split('/')[0]}"
    #if (params[:controller].split('/')[0] == 'admins')
    if (devise_controller? && resource_name == :admin || params[:controller].split('/')[0] == 'admins')
      "admin"
    else
      "user"
    end
  end

  def after_sign_in_path_for(resource)
   case resource
   when User
    '/users/welcome/index' 
   when Admin
    '/admins/welcome/index' 
  end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
