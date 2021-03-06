namespace :facebook do
  desc "TODO"
  task latest_post: :environment do
    setting = Admins::Setting.first
    client = Koala::Facebook::API.new(setting.facebook_token)
    date = (Date.today-4.days).strftime("%Y-%m-%d")
    Admins::Politician.all.each do |politician|
      if (politician.facebook && !politician.facebook.empty?)

        puts "#{politician.first_name} #{politician.last_name} #{politician.facebook}"
        messages = client.get_connection(politician.facebook, 'posts', {
          since: date,
          fields: ['message', 'id', 'picture', 'created_time']
        })
        messages.each do |message_record|
          post = Admins::Post.find_by(social_id: message_record["id"])

          if (post)
            puts "Post found #{message_record["id"]}"
          else
            politician.posts.build(social_id: message_record["id"], social_type: Admins::Post.social_types[:facebook], social_date: message_record["created_time"])
            social_date = DateTime.parse(message_record["created_time"])
            if (!politician.latest_social)
              politician.latest_social = social_date
            else
              if (politician.latest_social < social_date)
                politician.latest_social = social_date
              end 
            end
            politician.save 
          end
        end
      end
    end
  end

end
