class Api::V1::DistrictsController < Api::V1::BaseController
  def index
    if (!params[:state_id])
      districts = Admins::District.all
    else
      districts = Admins::District.where(state_id: params[:state_id])
    end
    render json: districts, each_serializer: Api::V1::DistrictSerializer
  end
  def find
    if (params[:state])
      state = Admins::State.where(abbreviation: params[:state]).first


      districts = Admins::District.where(state_id: state.id)
      if (districts.length == 1)
        Rails.logger.debug "NANCY: district.id: #{districts[0].id}, district.name: #{districts[0].name}"
      end
    end

    if (params[:zip])
    end
    #response = Faraday.get 'https://www.googleapis.com/civicinfo/v2/elections?key=AIzaSyCnf229S5uGfG2gRpnE6npbHXZZgOxOyNo'
    render json:  "{}" 
  end
end
