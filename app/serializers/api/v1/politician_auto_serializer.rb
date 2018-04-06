class Api::V1::PoliticianAutoSerializer < Api::V1::BaseSerializer
  attribute :id
  attribute :name, key: :label
  attribute :name, key: :value
end
