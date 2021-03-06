# recommend utilizing a gem such as Faker to generate User array
#
# ADD CODE HERE from a gem such as Faker
# format each user object as [{ email: 'email@email.com', firstname: "firstname", lastname: "lastname"} ]
#
# generate users AFTER building an array of user objects
# users.each { |user|
#   user = User.new(
#     email: user[:email],
#     password: '123456789',
#     password_confirmation: '123456789',
#     firstname: user[:firstname],
#     lastname: user[:lastname]
#   )
#
#   # DEVISE User adjustments
#   user.skip_confirmation! # if you prefer to skip a users confirmation after creation leave this uncommented
#   user.save!              # if you are skipping confirmations and want to just confirm them automatically
#   user.confirm            # if user has properly saved to the database and you wanted to skip the confirmation e-mail and confirm them in the DB
# }

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
