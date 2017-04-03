class Api::V1::ElectionsController < Api::V1::BaseController
  def index
    elections = Admins::Election.all
    render json: elections, each_serializer: Api::V1::ElectionSerializer
  end
end
