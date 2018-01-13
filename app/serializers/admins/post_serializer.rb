class Admins::PostSerializer < ActiveModel::Serializer
  attributes :id, :message, :image
end
