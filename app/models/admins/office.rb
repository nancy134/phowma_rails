class Admins::Office < ApplicationRecord
  belongs_to :state, class_name: 'Admins::State'
  belongs_to :district, class_name: 'Admins::District'
  belongs_to :politician, class_name: 'Admins::Politician'
  has_many   :elections, class_name:'Admins::Office'

  enum position: [:senator, :representative, :governor]

end
