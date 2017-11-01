
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

end
