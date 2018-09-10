class Api::V1::CampaignsController < Api::V1::BaseController
  def index
    campaigns = Admins::Campaign.ransack(params[:q])
    render json: campaigns.result, each_serializer: Api::V1::CampaignSerializer, include: ['election', 'election.office.state', 'election.office.district', 'politician.posts']
  end
end
