class Api::V1::AreaCodesController < Api::V1::BaseController
  def index
    area_codes = Admins::AreaCode.all
    render json: area_codes, each_serializer: Api::V1::AreaCodeSerializer
  end
end

