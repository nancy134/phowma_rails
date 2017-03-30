class Admins::WelcomeController < ApplicationController
  def index
    Rails.logger.debug "NANCY: params:controller #{params[:controller]}"
  end
end
