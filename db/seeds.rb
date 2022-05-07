# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  expencesList =  [
    [ "Food" ],
    [ "Transport"],
    [ "Closes"],
    [ "mobile phone"],
    [ "technic"],
    [ "presents"],
    [ "cosmetic"],
    [ "public services"]
  ]

  expencesList.each do |name|
    Expence.create( name: name,
                    description: name,
                    user_id: 1,
                    predefined: true)
    end
# Expence.create!([{
#                  name: "Food",
#                  description: "Meat, fruit, vegetables and so on",
#                  user_id: 1,
#                  predefined: true
#                },
#                ])

p "Created #{Expence.count} items"