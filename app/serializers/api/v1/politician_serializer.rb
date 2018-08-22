class Api::V1::PoliticianSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :party, :picture, :avatar_thumb, :avatar_medium, :twitter, :facebook, :latest_social 
  has_many :posts, serializer: Api::V1::PostSerializer
  has_one :office, serializer: Api::V1::OfficeSerializer 
  def posts
    object.posts.order(social_date: :desc).limit(2)
  end
end
