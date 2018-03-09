class Admins::Office < ApplicationRecord
  belongs_to :state, class_name: 'Admins::State'
  belongs_to :district, class_name: 'Admins::State'
  belongs_to :politician, class_name: 'Admins::Politician'

  enum position: [:senator, :representative, :governor]
end
