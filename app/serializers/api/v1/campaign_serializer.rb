class Api::V1::CampaignSerializer < Api::V1::BaseSerializer
  attributes :id
  belongs_to :election, serializer: Api::V1::ElectionSerializer
  belongs_to :politician, serializer: Api::V1::PoliticianSerializer
end
