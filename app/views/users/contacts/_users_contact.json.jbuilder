json.extract! users_contact, :id, :phone_id, :user_id, :created_at, :updated_at
json.url users_contact_url(users_contact, format: :json)
