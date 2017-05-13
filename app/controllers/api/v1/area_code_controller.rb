class Api::V1::AreaCodesController < Api::V1::BaseController
  def index
    if (params[:code])
      area_codes = Admins::AreaCode.where(code: params[:code])
    else
      area_codes = Admins::AreaCode.all
    end
    render json: area_codes, each_serializer: Api::V1::AreaCodeSerializer
  end
end

