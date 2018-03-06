class Admins::Election < ApplicationRecord

  has_many :election_results, class_name: 'Admins::ElectionResult'
  belongs_to :state, class_name: "Admins::State"
  belongs_to :district, class_name: "Admins::District"
  belongs_to :politician, class_name: "Admins::Politician"

  enum position: [:president, :senate, :house, :governor]
  enum election_type: [:primary, :general, :runoff]
  def election_name
    return self.position + " " + self.year.to_s
  end
end
