class Api::V1::SettingsController < Api::V1::BaseController
  def index
    states = Admins::State.order(:name)
    render json: {:parties => Admins::Politician.parties,
                  :positions => Admins::Politician.positions,
                  :states => states}
  end    
end
