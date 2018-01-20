namespace :data do
  desc "TODO"
  task fix_district: :environment do
    Admins::Politician.all.each do |politician|
      if (!politician.representative?)
        puts "Removing district from: #{politician.first_name} #{politician.last_name}"
        politician.district_id = nil
        politician.save
      end
    end
  end

end
