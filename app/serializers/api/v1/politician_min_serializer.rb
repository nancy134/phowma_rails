class Api::V1::PoliticianMinSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :party, :avatar_thumb
end
