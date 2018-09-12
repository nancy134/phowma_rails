json.extract! admins_message, :id, :name, :email, :message, :created_at, :updated_at
json.url admins_message_url(admins_message, format: :json)
