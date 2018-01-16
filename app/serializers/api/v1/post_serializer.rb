class Api::V1::PostSerializer < Api::V1::BaseSerializer
  attributes :id, :social_id, :social_type, :social_date, :isToday, :isYesterday
end
