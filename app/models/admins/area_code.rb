class Admins::AreaCode < ApplicationRecord
  belongs_to :state, class_name: 'Admins::State'
end
