class Admins::State < ApplicationRecord
  require 'csv'

  has_many :politicians, class_name: 'Admins::Politician'
  has_many :area_codes, class_name: 'Admins::Area_Code'
  has_many :election_results, class_name: 'Admins::Election_Result'

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
end
