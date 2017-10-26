class Api::V1::PoliticiansController < Api::V1::BaseController
  def index

    
    if (params[:state])
      if (params[:state].length == 2)
        state = Admins::State.where(abbreviation: params[:state]).first
      else
        state = Admins::State.where(name: params[:state]).first
      end
      if (state)
        politicians = Admins::Politician.where(state_id: state.id)
      end
      render json: politicians, each_serializer: Api::V1::PoliticianSerializer
    elsif (params[:district])
      politicians = Admins::Politician.joins(:district).merge(Admins::District.where(id: params[:district]))
      paginate json: politicians, each_serializer: Api::V1::PoliticianSerializer
    else
      rpoliticians = Admins::Politician.ransack(params[:q])
      politicians = rpoliticians.result.joins(:state).order("admins_states.name")
      paginate json: politicians, each_serializer: Api::V1::PoliticianSerializer
    end
  end
end
