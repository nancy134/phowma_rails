class Admins::Election < ApplicationRecord

  has_many :election_results, class_name: 'Admins::ElectionResult'
  belongs_to :state, class_name: "Admins::State"
  belongs_to :district, class_name: "Admins::District"

  enum position: [:president, :senate, :congress, :governor]

  def election_name
    return self.position + " " + self.year.to_s
  end
end
