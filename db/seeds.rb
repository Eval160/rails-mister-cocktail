# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Delete all dose"
Dose.delete_all

puts "Delete all cocktails"

Cocktail.delete_all

puts "Delete all ingredients"

Ingredient.delete_all

url_ingregients = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredients = JSON.parse(open(url_ingregients).read)["drinks"]

puts "Create new ingredients"
ingredients.each do |ingredient|
  new_ingredient = Ingredient.new(name: ingredient["strIngredient1"])
  new_ingredient.save!
end



puts "Create new cocktails"

("a".."t").each do |letter|
  url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
  drinks = JSON.parse(open(url).read)["drinks"]

  drinks.each do |drink|
    name = drink["strDrink"]
    cocktail = Cocktail.new(name: name)
    cocktail.save!
    i = 1

    ingredients = []
    measures = []
    until drink["strIngredient#{i}"].nil?
      ingredient = drink[ "strIngredient#{i}"]
      ingredients << ingredient
      measure = drink["strMeasure#{i}"]
      measures << measure
      i += 1
    end
          j = 0
      ingredients.each do |ingredient|
        dose = Dose.new(description: measures[j])
        if dose.description.nil?
        else
          ingredient_exist = Ingredient.where(name: ingredient)[0]
          if ingredient_exist.nil?
            j += 1
          else
            dose.ingredient = ingredient_exist
            dose.cocktail = cocktail
            if dose.valid?
              dose.save!
              j += 1
            else
              j += 1
            end
          end
        end
      end
  end
end

puts "Finish"
