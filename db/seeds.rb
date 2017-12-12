# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all

#seeding products
20.times do
  Product.create!(
    name: Faker::Beer.unique.name,
    price: Faker::Number.between(5, 100)
  )
end

1.times do
  User.create!(
    name: "Mark",
    email: "test@gmail.com",
    password: "11111111"
  )
end

p "Created #{Product.count} products"
p "Created #{User.count} user"
