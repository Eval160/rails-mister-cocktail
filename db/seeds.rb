# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Delete all ingredients"
Ingredient.delete_all
# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")
# Ingredient.create(name: "vodka")
# Ingredient.create(name: "rhum")
# Ingredient.create(name: "orange juice")
# Ingredient.create(name: "tequila")
# Ingredient.create(name: "tomato juice")
# Ingredient.create(name: "ananas juice")

url = url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredients = JSON.parse(open(url).read)["drinks"]

puts "Create new ingredients"
ingredients.each do |ingredient|
  new_ingredient = Ingredient.new(name: ingredient["strIngredient1"])
  new_ingredient.save!
end

puts "Finish"
