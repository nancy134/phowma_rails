class Api::V1::PoliticianSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :party, :position, :picture
  belongs_to :district
end
