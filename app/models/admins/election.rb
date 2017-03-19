class Admins::Election < ApplicationRecord

  has_many :election_results, class_name: 'Admins::Election_Result'

  enum position: [:president, :senate, :congress, :governor]

  def election_name
    return self.position + " " + self.year.to_s
  end
end
