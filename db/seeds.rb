# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['user', 'resident', 'partner', 'admin'].each do |role|
  Role.find_or_create_by_name role
end

alfred = User.create(email: "hi@gmail.com", password: '12345678', role_id: 1)
donor1 = Donor.create(name: "Joe Schmo", user_id: alfred.id)
# donation1 = Donation.create( amount: 100, donor_id: donor1.id )

