class StatesGrid

  include Datagrid

  scope do
    Admins::State
  end

  filter(:name, :string) { |value| where("name LIKE ?", "%#{value}%") } 

  column(:id)
  column(:name)
  column(:abbreviation)
end
