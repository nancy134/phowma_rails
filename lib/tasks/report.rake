
namespace :report do
  desc "TODO"
  task districts: :environment do
    file = "districts.csv"
    header = "id,name,state"
    
    File.open(file, 'w') do |csv|
      csv << header
      csv << "\n"
      Admins::District.all.each do |district|
        csv << "#{district.id},#{district.name},#{district.state.name}"
        csv << "\n"
      end
    end
  end

  desc 'Politician report'
  task politicians: :environment do
    file = "politicians.csv"
    header = "id,state.id,state.abbr,first_name,last_name,position,party,twitter,facebook,district.id,district.name,thumb"
    File.open(file, 'w') do |csv|
      csv << header
      csv << "\n"
      Admins::Politician.all.each do |politician|
        if (politician.district)
          csv << "#{politician.id},#{politician.state.id},#{politician.state.abbreviation},#{politician.first_name},#{politician.last_name},#{politician.position},#{politician.party},#{politician.twitter},#{politician.facebook},#{politician.district.id},#{politician.district.name},#{politician.avatar_thumb}"
        else
          csv << "#{politician.id},#{politician.state.id},#{politician.state.abbreviation},#{politician.first_name},#{politician.last_name},#{politician.position},#{politician.party},#{politician.twitter},#{politician.facebook},,,#{politician.avatar_thumb}"
        end
        csv << "\n"
      end
    end
  end

  desc 'State report'
  task states: :environment do
    file = "states.csv"
    header = "id,name,abbreviation"
    File.open(file,'w') do |csv|
      csv << header
      csv << "\n"
      Admins::State.all.each do |state|
        csv << "#{state.id},#{state.abbreviation},#{state.name}"
        csv << "\n"
      end
    end
  end

  desc 'Election report'
  task elections: :environment do
    file = "elections.csv"
    header = "id,position,date,state_id,district_id,politician_id,election_type,wikipedia"
    File.open(file,'w') do |csv|
      csv << header
      csv << "\n"
      Admins::Election.all.each do |election|
        csv << "#{election.id},#{election.position},#{election.date},#{election.state_id},#{election.district_id},#{election.politician_id},#{election.election_type},#{election.wikipedia}"
        csv << "\n"
      end
    end
  end
end
