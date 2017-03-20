class Admins::Election < ApplicationRecord

  has_many :election_results, class_name: 'Admins::ElectionResult'

  enum position: [:president, :senate, :congress, :governor]

  def election_name
    return self.position + " " + self.year.to_s
  end
end
