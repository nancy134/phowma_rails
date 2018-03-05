class Api::V1::ElectionSerializer < Api::V1::BaseSerializer
  attributes :election_name, :date, :position
  belongs_to :state, serializer: Api::V1::StateMinSerializer
  belongs_to :district
  belongs_to :politician, serializer: Api::V1::PoliticianSerializer
end
