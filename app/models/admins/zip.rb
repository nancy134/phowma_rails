class Admins::Zip < ApplicationRecord
  has_and_belongs_to_many :districts, class_name: 'Admins::District', join_table: 'admins_districts_zips'
end
