class Api::V1::OfficeSerializer < Api::V1::BaseSerializer
  attributes :id, :position
  belongs_to :state, serializer: Api::V1::StateMinSerializer
  belongs_to :district, serializer: Api::V1::DistrictSerializer
  belongs_to :politician, serializer: Api::V1::PoliticianMinSerializer
end
