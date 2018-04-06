class Admins::Campaign < ApplicationRecord
  belongs_to :politician
  belongs_to :election

  attr_accessor :date
  attr_accessor :state_id
  attr_accessor :district_id
  attr_accessor :position
  attr_accessor :politician_last_name
end
