# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
  {firstname: "Michelle", lastname: "Cabalic", email: "michelle.sanz1@gmail.com"},
  {firstname: "Gloria", lastname: "Galindo", email: "gloriagalindo08@gmail.com"},
  {firstname: "Leona", lastname: "Faasolo", email: "Leona_faasolo@me.com"},
  {firstname: "Loren", lastname: "Enochson", email: "lorenenochson@gmail.com"},
  {firstname: "Joanne", lastname: "Del Rasario", email: "joanne.vison@yahoo.com"},
  {firstname: "Shayna", lastname: "Sylvia", email: "ssylvia9s@gmail.com"},
  {firstname: "Shannon", lastname: "Lojko", email: "shannonmlh@gmail.com"},
  {firstname: "Rocio", lastname: "Gronachon", email: "rgronachon@juut.com"}
]

users.each { |user|
  user = User.new(
    email: user[:email],
    password: '123456789',
    password_confirmation: '123456789',
    firstname: user[:firstname],
    lastname: user[:lastname]
  )
  user.skip_confirmation!
  user.save!
  user.confirm
}
