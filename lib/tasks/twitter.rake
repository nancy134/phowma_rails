namespace :twitter do
  desc "TODO"
  task latest_tweet: :environment do

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    Admins::Politician.all.each do |politician|
      if (politician.twitter)
        user_timeline = client.user_timeline(politician.twitter, {count: 10, include_rts: false, trim_user: true, exclude_replies: true, include_entities: true})

        user_timeline.each do |tweet|
          puts "tweet.id: #{tweet.id}"
          puts "tweet.text: #{tweet.text}"
          puts "tweet.created_at #{tweet.created_at}"
          if (tweet.entities?)
            entities = Twitter::Extractor.extract_entities_with_indices(tweet.text)
            entities.each do |entity|
              #puts "entitie: #{entity}"
            end
          end


          if (tweet.media.present?)
            tweet.media.each do |media_item|
                puts "media_item.url: #{media_item.media_url}"
            end
          end

        end
      end
    end
  end
end
