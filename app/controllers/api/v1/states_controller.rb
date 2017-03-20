class Api::V1::StatesController < Api::V1::BaseController
  def index
    states = Admins::State.all
    sorted_states = states.sort_by { |obj| obj.total }
    render json: sorted_states, each_serializer: Api::V1::StateSerializer
  end
end
