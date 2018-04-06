class Api::V1::OfficesController < Api::V1::BaseController
  def index
    offices = Admins::Office.ransack(params[:q]).result
    #offices = Admins::Office.all
    render json: offices, each_serializer: Api::V1::OfficeSerializer
  end
end

