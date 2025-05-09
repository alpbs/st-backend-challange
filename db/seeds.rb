# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create!(name: "Andre Barros", email: "aluisbarrossilva@gmail.com", "balance": 1000)
Gasstation.create!(name: "Shell", address: "Rua 1, 123", price_per_liter: 5.9)
Gasstation.create!(name: "Petrobras", address: "Rua 2, 123", price_per_liter: 3.9)