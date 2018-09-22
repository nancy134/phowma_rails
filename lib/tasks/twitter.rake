namespace :twitter do
  desc "latest_tweet"
  task latest_tweet: :environment do

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    politicians = Admins::Politician.order("RANDOM()").limit(400)
    politicians.each do |politician|
      puts "#{politician.first_name} #{politician.last_name}"
      if (!politician.twitter.blank?)
        user = client.user(politician.twitter)
        politician.twitter_bio = user.status.text
        politician.twitter_image = user.profile_image_url_https
        politician.twitter_banner = user.profile_banner_url
        politician.save
      end
      if (politician.twitter.blank?)
        user_timeline = client.user_timeline(politician.twitter, {count: 2, include_rts: false, trim_user: true, exclude_replies: true, include_entities: true})

        user_timeline.each do |tweet|
          post = Admins::Post.find_by(social_id: tweet.id)
          if (post)
            puts "Post found #{tweet.id}"
          else
            puts "Post added #{tweet.id}"
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
  desc "cleanup old tweets"
  task cleanup: :environment do
    politicians = Admins::Politician.all
    politicians.each do |politician|
      puts "name: #{politician.first_name} #{politician.last_name}"
      posts = politician.posts
      puts "length: #{posts.length}"
      if (posts.length > 2)
        for i in 2..posts.length-1
          puts "posts: #{posts[i].social_date}"
          posts[i].destroy
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
  desc "twitter description"
  task get_description: :environment do

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    politicians = Admins::Politician.order("RANDOM()").limit(400)
    politicians.each do |politician|
      puts "#{politician.first_name} #{politician.last_name}"
      if (!politician.twitter.blank?)
        user = client.user(politician.twitter)
        #user_timeline = client.user_timeline(politician.twitter, {count: 1, include_rts: false, trim_user: true, exclude_replies: true, include_entities: true})
        #puts "user: #{user.to_json}"
        #puts "user_timeline: #{user_timeline.to_json}"
        politician.twitter_bio = user.status.text
        politician.twitter_image = user.profile_image_url_https
        politician.twitter_banner = user.profile_banner_url
        politician.save
      end
    end
  end
end
