json.extract! admins_post, :id, :message, :image, :created_at, :updated_at
json.url admins_post_url(admins_post, format: :json)
