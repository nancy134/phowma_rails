namespace :facebook do
  desc "TODO"
  task latest_post: :environment do

    client = Koala::Facebook::API.new("#{ENV['FACEBOOK_USER_ACCESS_TOKEN']}")

    Admins::Politician.all.each do |politician|
      if (politician.facebook)
        puts "#{politician.first_name} #{politician.last_name} #{politician.facebook}"
        messages = client.get_connection(politician.facebook, 'posts', {
          limit: 10,
          field: ['message', 'id', 'picture']
        })
        puts "messages: #{messages}"
      end
    end
  end

end
