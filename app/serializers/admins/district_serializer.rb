class Admins::DistrictSerializer < ActiveModel::Serializer
  attributes :id, :name, :state_id, :number
end
