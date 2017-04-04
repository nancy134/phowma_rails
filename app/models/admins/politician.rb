class Admins::Politician < ApplicationRecord

  require 'csv'

  belongs_to :state, class_name: 'Admins::State'
  belongs_to :district, class_name: 'Admins::District'

  enum party: [:democrat, :republican, :independent]
  enum position: [:senator, :congressman, :governor]

  def self.import(file)
    CSV.foreach(file.path, headers: true, :row_sep => :auto) do |row|
      politician_hash = row.to_hash

      if (politician_hash["state"].length == 2)
        state = Admins::State.where(abbreviation: politician_hash["state"]).first
      else
        state = Admins::State.where(name: politician_hash["state"]).first
      end
      if (state)
        politician_hash["state_id"] = state.id
      else
        return
      end
      politician_hash.delete("state")
      politician = Admins::Politician.where(id: politician_hash["id"])

      if politician.count == 1
        politician.first.update_attributes(politician_hash)
      else
        Admins::Politician.create!(politician_hash)
      end
    end
  end
end

