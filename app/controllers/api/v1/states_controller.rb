class Api::V1::StatesController < Api::V1::BaseController
  def index
    if (params[:name])
      states = Admins::State.where(name: params[:name])
      render json: states, each_serializer: Api::V1::StateAllSerializer
    elsif (params[:abbreviation])
      states = Admins::State.where(abbreviation: params[:abbreviation])
      render json: states, each_serializer: Api::V1::StateAllSerializer
    else   
      states = Admins::State.all
      sorted_states = states.sort_by { |obj| obj.total }
      render json: sorted_states, each_serializer: Api::V1::StateSerializer
    end
  end
end
