class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: -> {params[:controller].split('/')[0] == 'devise_token_auth'}

  layout :layout_by_resource

  def layout_by_resource
    if (devise_controller? && resource_name == :admin || params[:controller].split('/')[0] == 'admins')
      "admin"
    else
      "user"
    end
  end

  def after_sign_in_path_for(resource)
   case resource
   when User
    if (cookies[:politician_id])
     politician_id = cookies[:politician_id]
     cookies.delete :politician_id
     return "/users/politicians/#{politician_id}"
    else
      return "/users/politicians"
    end
   when Admin
    session["admin_return_to"] || '/admins/welcome/index'
  end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
