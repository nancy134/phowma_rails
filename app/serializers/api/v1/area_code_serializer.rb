class Api::V1::AreaCodeSerializer < Api::V1::BaseSerializer
  attributes :code, :state_name, :state_abbr
end

