class Admins::SocialsController < ApplicationController

  before_filter :authenticate_admin!
  def index
    @user = current_user
  end

  def callback
    auth = request.env["omniauth.auth"]
    #render inline: auth.to_json
    oauth = Koala::Facebook::OAuth.new("1075987872547151", "a2eea589eab61925f8e5e8acb257edac")
    extended_token = oauth.exchange_access_token_info(auth["credentials"]["token"])
    @user = current_user
     #@user.update_with_omniauth(extended_token['access_token'])
    #render inline: @user.to_json

    render inline: extended_token.to_json

  end
  def connect
    redirect_to '/api/v1/admin_auth/facebook'
  end
end
