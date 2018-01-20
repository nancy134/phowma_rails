json.extract! admins_election, :id, :position, :state_id, :district_id, :year, :date, :created_at, :updated_at
json.url admins_election_url(admins_election, format: :json)
