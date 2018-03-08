class Admins::Campaign < ApplicationRecord
  belongs_to :politician
  belongs_to :election
end
