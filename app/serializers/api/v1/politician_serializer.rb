class Api::V1::PoliticianSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :party, :position, :picture, :avatar_thumb, :avatar_medium, :attribution, :posts
  belongs_to :district
  belongs_to :state

end
