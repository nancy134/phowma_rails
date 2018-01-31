class Api::V1::StatesController < Api::V1::BaseController
  def index
    if (params[:name])
      states = Admins::State.where(name: params[:name])
      render json: states, each_serializer: Api::V1::StateAllSerializer
    elsif (params[:abbreviation])
      states = Admins::State.where(abbreviation: params[:abbreviation])
      render json: states, each_serializer: Api::V1::StateAllSerializer
    else 
      states = Admins::State.order(:name)
      if (params[:type] == 'min')
        render json: states, each_serializer: Api::V1::StateMinSerializer
      elsif (params[:type] == 'list')
        render json: states, each_serializer: Api::V1::StateListSerializer
      else
        paginate json: states, each_serializer: Api::V1::StateAllSerializer
      end
    end
  end
end
