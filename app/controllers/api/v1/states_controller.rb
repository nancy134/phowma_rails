class Api::V1::StatesController < Api::V1::BaseController
  def index
    if (params[:name])
      states = Admins::State.where(name: params[:name])
    elsif (params[:abbreviation])
      states = Admins::State.where(abbreviation: params[:abbreviation])
    else   
      states = Admins::State.all
    end
    sorted_states = states.sort_by { |obj| obj.total }
    render json: sorted_states, each_serializer: Api::V1::StateSerializer
  end
end
