# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  name = Faker::Name.first_name
  User.create!(name: name)
end

5.times do
  priority = rand(0..9)
  name = Faker::Superhero.prefix
  Category.create!(name: name, priority: priority)
end

5.times do
  author_id = rand(1..5)
  category_id = rand(1..5)
  title = Faker::Dessert.variety
  text = Faker::Lorem.paragraph(sentence_count: 2)
  Article.create!(title: title, text: text, category_id: category_id, author_id: author_id)
end
