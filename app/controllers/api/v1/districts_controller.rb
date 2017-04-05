class Api::V1::DistrictsController < Api::V1::BaseController
  def index
    Rails.logger.debug "NANCY: state_id: #{params[:state_id]}"
    if (!params[:state_id])
      districts = Admins::District.all
    else
      districts = Admins::District.where(state_id: params[:state_id])
    end
    render json: districts, each_serializer: Api::V1::DistrictSerializer
  end
end
