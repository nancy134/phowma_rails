json.extract! admins_politician, :id, :name, :first_name, :last_name, :party, :office_id, :twitter, :twitter_bio, :twitter_image, :twitter_banner, :facebook, :created_at, :updated_at
json.url admins_politician_url(admins_politician, format: :json)
