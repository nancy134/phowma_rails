class Admins::Politician < ApplicationRecord
  belongs_to :state, class_name: 'Admins::State'
  enum party: [:democrat, :republican, :independent]
end
