class Api::V1::StateSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :abbreviation, :total, :stars
  has_many :politicians
end
