
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
    header = "id,state,first,last"
    File.open(file, 'w') do |csv|
      csv << header
      csv << "\n"
      Admins::Politician.all.each do |politician|
        csv << "#{politician.id},#{politician.state.abbreviation},#{politician.first_name},#{politician.last_name},#{politician.position},#{politician.party},#{politician.twitter},#{politician.facebook},#{politician.avatar_thumb},#{politician.district.name}"
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
end
