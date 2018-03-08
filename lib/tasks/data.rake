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

  desc "import_elections"
  task import_elections: :environment do

    require 'csv'

    csv_text = File.read('/tmp/elections.csv')
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|

      election_row = row.to_hash
       
      #politician_id
      #state_id
      election_row.delete("state.abbr")
      election_row.delete("first_name")
      election_row.delete("last_name")
      #position
      election_row.delete("party")
      election_row.delete("twitter")
      election_row.delete("facebook")
      #district_id
      election_row.delete("district.name")
      election_row.delete("election")
      #running
      #date

      if (election_row["running"] === "no")
        election_row.delete("politician_id")
      end
      election_row.delete("running") 

      puts "#{election_row.to_json}"
      Admins::Election.create!(election_row)
    end
  end

  desc "import campaigns"
  task import_campaigns: :environment do
    require 'csv'

    csv_text = File.read('/tmp/campaigns.csv')
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      campaign_row = row.to_hash
      Admins::Campaign.create!(campaign_row)
    end

  end

  desc "add general election"
  task add_general_election: :environment do
    Admins::Election.all.each do |election|
      election.election_type = "general"
      election.save
    end
  end
end
