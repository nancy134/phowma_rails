class Admins::OfficeSerializer < ActiveModel::Serializer
  attributes :id, :position, :state_id, :district_id, :politician_id
end
