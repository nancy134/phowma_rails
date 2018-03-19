class Admins::Office < ApplicationRecord
  belongs_to :state, class_name: 'Admins::State'
  belongs_to :district, class_name: 'Admins::District'
  belongs_to :politician, class_name: 'Admins::Politician'
  has_many   :elections, class_name:'Admins::Office'

  enum position: [:senator, :representative, :governor]

  def politician_last_name
    politician.try(:last_name)
  end

  def politician_last_name=(last_name)
    #self.politician = Admins::Politician.find_by(last_name: last_name) if last_name.present?
  end
end
