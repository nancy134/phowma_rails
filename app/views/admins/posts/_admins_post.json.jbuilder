json.extract! admins_post, :id, :message, :image, :social_id, :social_type, :social_date, :created_at, :updated_at
json.url admins_post_url(admins_post, format: :json)
