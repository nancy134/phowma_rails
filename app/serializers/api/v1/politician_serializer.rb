class Api::V1::PoliticianSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :party, :position, :picture, :avatar_thumb, :avatar_medium, :twitter, :facebook, :attribution, :latest_social 
  belongs_to :district
  belongs_to :state
  has_many :posts, serializer: Api::V1::PostSerializer 
end
