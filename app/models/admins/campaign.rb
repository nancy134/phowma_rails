class Admins::Campaign < ApplicationRecord
  belongs_to :politician
  belongs_to :election
  has_one :office, :through => :election

  validates_presence_of :politician
  validates_presence_of :election

  before_validation :set_selected_election
  before_validation :set_selected_politician

  accepts_nested_attributes_for :election
  accepts_nested_attributes_for :politician

  attr_accessor :candidate_name
  attr_accessor :date_id

  def set_selected_politician
    self.politician = Admins::Politician.find(politician_id)
  end

  def set_selected_election
    Rails.logger.debug "date_id: #{date_id}"
    self.election = Admins::Election.find(date_id)
  end

  def candidate_name
    if (self.politician)
      "#{self.politician.first_name} #{self.politician.last_name}"
    else
      ""
    end
  end

end
