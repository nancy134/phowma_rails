class Api::V1::ElectionsController < Api::V1::BaseController
  def index
    relections = Admins::Election.ransack(params[:q])
    elections = relections.result.joins(:state).order("admins_states.name")
    paginate json: elections, each_serializer: Api::V1::ElectionSerializer
  end
end
