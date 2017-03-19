class Admins::ElectionResult < ApplicationRecord
  require 'csv'

  belongs_to :election, class_name: 'Admins::Election'
  belongs_to :state, class_name: 'Admins:State'

  enum party: [:democrat, :republican, :independent]

  def self.import(file)
    CSV.foreach(file.path, headers: true, :row_sep => :auto) do |row|
      election_result_hash = row.to_hash

      if (election_result_hash["state"].length == 2)
        state = Admins::State.where(abbreviation: election_result_hash["state"]).first
      else
        state = Admins::State.where(name: election_result_hash["state"]).first
      end
      if (state)
        election_result_hash["state_id"] = state.id
      else
        return
      end
      election_result_hash.delete("state")

      election = Admins::Election.where(position: election_result_hash["position"], year: election_result_hash["year"]).first
      if (election)
        election_result_hash["election_id"] = election.id
      else
        return
      end
      election_result_hash.delete("year")
      election_result_hash.delete("position")
      election_result = Admins::ElectionResult.where(id: election_result_hash["id"])

      if election_result.count == 1
        election_result.first.update_attributes(election_result_hash)
      else
        Admins::ElectionResult.create!(election_result_hash)
      end
    end
  end

end
