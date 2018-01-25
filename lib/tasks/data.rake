namespace :data do
  desc "fix district"
  task fix_district: :environment do
    Admins::Politician.all.each do |politician|
      if (!politician.representative?)
        puts "Removing district from: #{politician.first_name} #{politician.last_name}"
        politician.district_id = nil
        politician.save
      end
    end
  end

  desc "import social"
  task import_social: :environment do
    require 'csv'
    csv_text = File.read('/tmp/social.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      politician_row = row.to_hash
      politician = Admins::Politician.where(id: politician_row["id"].to_i).first
      puts "politiican.id: #{politician.id}"
      update = false
      if (politician_row["twitter"])
        politician.twitter = politician["twitter"]
        update = true
      end
      if (politician_row["facebook"])
        politician.facebook = politician["facebook"]
        update = true
      end
      if (update)
        puts "politician: #{politician}"
        politician.save
        update = false
      end
    end
  end

end
