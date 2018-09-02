class Api::V1::StateListSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :abbreviation, :senate_election
  has_many :districts, serializer: Api::V1::DistrictMinSerializer
end
