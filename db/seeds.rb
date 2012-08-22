# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# # System Accounts:
# User.create! do |u|
#  u.email = 'eddie@codeforamerica.org'
#  u.name = 'Eddie A Tejeda'
#  u.password = 'password'
#  u.password_confirmation = 'password'
# end


# # Departments:
# Department.create! do |d|
#  d.name = 'Department of Education'
#  d.email = 'eddie@codeforamerica.org'
# end

# Department.create! do |d|
#  d.name = 'Department of Labor'
#  d.email = 'eddie@codeforamerica.org'
# end

# Department.create! do |d|
#  d.name = 'Department of Revenue'
#  d.email = 'eddie@codeforamerica.org'
# end

# Department.create! do |d|
#  d.name = 'Department of Health'
#  d.email = 'eddie@codeforamerica.org'
# end


# # Requester
Requester.destroy_all

800.times do
 Requester.create! do |r|
  r.email = Faker::Internet.email
  r.name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
  r.phone = Faker::PhoneNumber.phone_number
  r.mailing_address = "#{Faker::Address.street_address()} , #{Faker::Address.city()}, #{Faker::Address.state_abbr()} }"
 end
end


# Requests:
Request.destroy_all

1000.times do
 Request.create! do |r|

  r.department = Department.first(:offset => rand(Department.count))
  r.requester = Requester.first(:offset => rand(Requester.count))
  r.body = Faker::Lorem.paragraph(5)
  r.subject = Faker::Lorem.sentence
  r.status = 'Pending'

 end
end

# # Responses:
Response.destroy_all

700.times do
 Response.create! do |r|
  request = Request.first(:offset => rand(Request.count))

  r.request = request
  r.body = Faker::Lorem.paragraph(5)

  request.status = ['Pending', 'Fullfilled', 'Denied'].sample
  request.save!

 end
end
