class Api::V1::ElectionsController < Api::V1::BaseController
  def index
    relections = Admins::Election.ransack(params[:q])
    elections = relections.result.joins(:state).order(date: :asc)
    paginate json: elections, each_serializer: Api::V1::ElectionSerializer
  end
end
