# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# UNCOMMENT THIS ONCE YOU CREATE AN ARRAY OF USER NAME/EMAIL OBJECTS
# generate users after building an array of user objects
# users.each { |user|
#   user = User.new(
#     email: user[:email],
#     password: '123456789',
#     password_confirmation: '123456789',
#     firstname: user[:firstname],
#     lastname: user[:lastname]
#   )
#   user.skip_confirmation!
#   user.save!
#   user.confirm
# }

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
