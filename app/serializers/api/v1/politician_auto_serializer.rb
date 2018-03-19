class Api::V1::PoliticianAutoSerializer < Api::V1::BaseSerializer
  attribute :id
  attribute :name, key: :label
  attribute :last_name, key: :value
end
