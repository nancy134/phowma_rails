class Admins::District < ApplicationRecord

  require 'csv'

  belongs_to :state, class_name: 'Admins::State'
  has_one :politician, class_name: 'Admins::Politician'
  has_many :elections, class_name: 'Admins::Election'

  def self.import(file)
    CSV.foreach(file.path, headers: true, :row_sep => :auto) do |row|
      district_hash = row.to_hash

      if (district_hash["state"].length == 2)
        state = Admins::State.where(abbreviation: district_hash["state"]).first
      else
        state = Admins::State.where(name: district_hash["state"]).first
      end
      if (state)
        district_hash["state_id"] = state.id
      else
        return
      end
      district_hash.delete("state")
      district = Admins::District.where(id: district_hash["id"])

      if district.count == 1
        district.first.update_attributes(district_hash)
      else
        Admins::District.create!(district_hash)
      end
    end
  end
end
