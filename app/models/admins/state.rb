class Admins::State < ApplicationRecord
  require 'csv'

  has_many :politicians, class_name: 'Admins::Politician'
  has_many :area_codes, class_name: 'Admins::AreaCode'
  has_many :election_results, class_name: 'Admins::ElectionResult'
  has_many :districts, class_name: 'Admins::District'
  has_many :elections, class_name: 'Admins::Election'

  def self.import(file)
    CSV.foreach(file.path, headers: true, :row_sep => :auto) do |row|
      state_hash = row.to_hash
      state = Admins::State.where(id: state_hash[:id])

      if state.count == 1
        state.first.update_attributes(state_hash)
      else
        Admins::State.create!(state_hash)
      end
   end

  end

  def congress
    politician = politicians.where(position: "congressman")
    return politician.length
  end
  def congress_dems
    politician = politicians.where(position: "congressman", party: "democrat")
    return politician.length
  end
  def congress_dem_percentage
    if self.abbreviation == "DC"
       return 100
    else
      return self.congress_dems.to_f/self.congress.to_f*100
    end
  end
  def senate
    politician = politicians.where(position: "senator")
    return politician.length
  end
  def senate_dems
    politician = politicians.where(position: "senator", party: ["democrat","independent"])
    return politician.length
  end
  def senate_dem_percentage
    if self.abbreviation == "DC"
      return 100
    else
      return self.senate_dems.to_f/self.senate.to_f*100
    end
  end
  def governor_dems
    politician = politicians.where(position: "governor", party: ["democrat", "independent"])
    return politician.length
  end
  def governor_dem_percentage
    if self.abbreviation == "DC"
      return 100
    else 
      return self.governor_dems.to_f*100
    end
  end
  def president_2016
    er = election_results.first

    if (er && er.party == "democrat")
      return 100
    else
      return 0
    end
  end
  def stars
    return [president_2016,senate_dem_percentage, congress_dem_percentage, governor_dem_percentage, 0]
  end
  def total
    return president_2016+senate_dem_percentage+congress_dem_percentage+governor_dem_percentage
  end

end
