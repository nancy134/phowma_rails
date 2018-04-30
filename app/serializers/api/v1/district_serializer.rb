class Api::V1::DistrictSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :number
  has_one :politician, serializer: Api::V1::PoliticianMinSerializer
  belongs_to :state, serializer: Api::V1::StateMinSerializer
end
