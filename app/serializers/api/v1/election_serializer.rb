class Api::V1::ElectionSerializer < Api::V1::BaseSerializer
  attributes :id, :date, :election_type, :wikipedia
  belongs_to :office, serializer: Api::V1::OfficeSerializer
end
