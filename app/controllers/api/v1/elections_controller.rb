class Api::V1::ElectionsController < Api::V1::BaseController
  def index
    elections = Admins::Election.ransack(params[:q])
    paginate json: elections.result, each_serializer: Api::V1::ElectionSerializer, include: ['office', 'office.state', 'office.politician']
  end
end
