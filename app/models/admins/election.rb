class Admins::Election < ApplicationRecord
  enum position: [:president, :senate, :congress, :governor]
end
