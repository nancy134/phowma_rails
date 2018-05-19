class Api::V1::CampaignsController < Api::V1::BaseController
  def index
    campaigns = Admins::Campaign.ransack(params[:q])
    paginate json: campaigns.result, each_serializer: Api::V1::CampaignSerializer, include: ['election', 'election.office.state', 'politician']
  end
end
