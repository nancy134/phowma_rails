json.extract! admins_state, :id, :name, :abbreviation, :registered, :voting, :created_at, :updated_at
json.url admins_state_url(admins_state, format: :json)
