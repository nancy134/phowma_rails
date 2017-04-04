json.extract! admins_politician, :id, :name, :first_name, :last_name, :party, :position, :state_id, :district_id, :created_at, :updated_at
json.url admins_politician_url(admins_politician, format: :json)
