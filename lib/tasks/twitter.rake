namespace :twitter do
  desc "TODO"
  task latest_tweet: :environment do
    Admins::Politician.all.each do |politician|
      puts "Removing district from: #{politician.first_name} #{politician.last_name}"
    end
  end

end
