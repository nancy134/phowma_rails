class Admins::SocialsController < ApplicationController

  before_filter :authenticate_admin!
  def index
    @user = current_user
    @setting = Admins::Setting.first
  end

  def callback
    auth = request.env["omniauth.auth"]
    oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'])
    extended_token = oauth.exchange_access_token_info(auth["credentials"]["token"])
    setting = Admins::Setting.first
    if (setting)
      setting.update(facebook_token: extended_token["access_token"])
    else
      setting = Admins::Setting.new(facebook_token: extended_token["access_token"])
    end
    setting.save
    render inline: setting.to_json

  end
  def connect
    redirect_to '/api/v1/admin_auth/facebook'
  end
end
