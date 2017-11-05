namespace :facebook do
  desc "TODO"
  task latest_post: :environment do
    setting = Admins::Setting.first
    client = Koala::Facebook::API.new(setting.facebook_token)
    date = (Date.today-7.days).strftime("%Y-%m-%d")
    Admins::Politician.all.each do |politician|
      if (politician.facebook)
        puts "#{politician.first_name} #{politician.last_name} #{politician.facebook}"
        messages = client.get_connection(politician.facebook, 'posts', {
          since: date,
          fields: ['message', 'id', 'picture', 'link']
        })
        messages.each do |message_record|
          message = (message_record.is_a?(Hash) && message_record.key?("message")) ? message_record["message"] : nil
          picture = (message_record.is_a?(Hash) && message_record.key?("picture")) ? message_record["picture"] : nil
          link = (message_record.is_a?(Hash) && message_record.key?("link")) ? message_record["link"] : nil
          puts "message: #{message}"
          puts "picture: #{picture}"
          puts "link: #{link}"
          #puts "record: #{message_record}"
        end
      end
    end
  end

end
