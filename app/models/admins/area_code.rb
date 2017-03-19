class Admins::AreaCode < ApplicationRecord
  require 'csv'

  belongs_to :state, class_name: 'Admins::State'

  def self.import(file)
    CSV.foreach(file.path, headers: true, :row_sep => :auto) do |row|
      area_code_hash = row.to_hash

      if (area_code_hash["state"].length == 2)
        state = Admins::State.where(abbreviation: area_code_hash["state"]).first
      else
        state = Admins::State.where(name: area_code_hash["state"]).first
      end
      if (state)
        area_code_hash["state_id"] = state.id
      else
        return
      end
      area_code_hash.delete("state")
      area_code = Admins::AreaCode.where(id: area_code_hash["id"])

      if area_code.count == 1
        area_code.first.update_attributes(area_code_hash)
      else
        Admins::AreaCode.create!(area_code_hash)
      end
    end
  end

  def state_name
     return state.name
  end
  def state_abbr
     return state.abbreviation
  end

end
