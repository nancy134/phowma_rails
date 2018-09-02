class Admins::Office < ApplicationRecord
  belongs_to :state, class_name: 'Admins::State'
  belongs_to :district, class_name: 'Admins::District', :optional => true
  belongs_to :politician, class_name: 'Admins::Politician'
  has_many   :elections, class_name:'Admins::Office'

  enum position: [:senator, :representative, :governor]

  attr_accessor :incumbent_name

  def incumbent_name
    if (self.politician)
    "#{self.try(:politician).try(:first_name)} #{self.try(:politician).try(:last_name)}"
    else
      "Vacant"
    end
  end
end
