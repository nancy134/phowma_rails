json.extract! admins_election_result, :id, :party, :election_id, :state_id, :created_at, :updated_at
json.url admins_election_result_url(admins_election_result, format: :json)
