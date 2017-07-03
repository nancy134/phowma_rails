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
    else 
      #politicians = Admins::Politician.all
     # politicians = Admins::Politician.includes(:admins_state).order("admins_state.name desc")
      #politicians = Admins::Politician.find(:all, :joins => :state, :order => 'admins_states.name')
      politicians = Admins::Politician.joins(:state).order("admins_states.name")
      paginate json: politicians, each_serializer: Api::V1::PoliticianSerializer
    end
  end
end
