json.extract! users_politician, :id, :name, :first_name, :last_name, :party, :office_id, :twitter, :facebook, :created_at, :updated_at
json.url users_politician_url(users_politician, format: :json)
