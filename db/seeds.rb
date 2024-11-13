# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Team.destroy_all
Wallet.destroy_all

user1 = User.create!(
  username: 'user1',
  password: 'password1',
  name: 'Alice'
)
user2 = User.create!(
  username: 'user2',
  password: 'password2',
  name: 'Bob'
)

Wallet.create!(entity: user1, balance: 1000.0)
Wallet.create!(entity: user2, balance: 500.0)

team1 = Team.create!(
  username: 'team1',
  password: 'password3',
  name: 'Team Alpha'
)
team2 = Team.create!(
  username: 'team2',
  password: 'password4',
  name: 'Team Beta'
)

Wallet.create!(entity: team1, balance: 2000.0)
Wallet.create!(entity: team2, balance: 1500.0)