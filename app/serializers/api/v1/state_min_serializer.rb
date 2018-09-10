class Api::V1::StateMinSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :abbreviation, :registered, :voting
end
