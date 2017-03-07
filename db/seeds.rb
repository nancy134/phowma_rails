# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin1 = Admin.new :name => ENV["ADMIN_NAME"], :email => ENV["ADMIN_EMAIL"], :password => ENV["ADMIN_PASSWORD"], :confirmed_at => Time.now
admin1.skip_confirmation!
admin1.save!
