class Api::V1::ElectionSerializer < Api::V1::BaseSerializer
  attributes :election_name, :date, :position
  belongs_to :state
end
