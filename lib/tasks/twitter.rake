namespace :twitter do
  desc "latest_tweet"
  task latest_tweet: :environment do

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    Admins::Politician.all.each do |politician|
      puts "#{politician.first_name} #{politician.last_name}"
      if (politician.twitter)
        user_timeline = client.user_timeline(politician.twitter, {count: 2, include_rts: false, trim_user: true, exclude_replies: true, include_entities: true})

        user_timeline.each do |tweet|
          post = Admins::Post.find_by(social_id: tweet.id)
          if (post)
            puts "Post found #{tweet.id}"
          else
            politician.posts.build(social_id: tweet.id, social_type: Admins::Post.social_types[:twitter], social_date: tweet.created_at)
            social_date = tweet.created_at
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
  desc "yo_memo"
  task yo_memo: :environment do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    first = client.search('#yomemojokes').first
    puts "#{first.text}"


    client.search('#yomemojokes').take(20).each do |tweet|
      puts "#{tweet.text}"
    end
  end
end
