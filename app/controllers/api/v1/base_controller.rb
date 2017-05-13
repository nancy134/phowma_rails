class Api::V1::BaseController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  protect_from_forgery with: :null_session

  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end
end
