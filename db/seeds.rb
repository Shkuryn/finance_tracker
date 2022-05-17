# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
expencesList = [
  'food',
  'transport',
  'closes',
  'mobile phone',
  'technic',
  'presents',
  'cosmetic',
  'public services'
]
Expence.destroy_all
expencesList.each do |name|
  Expence.create(name: name,
                 description: name,
                 user_id: 1,
                 predefined: true)
end

p "Created #{Expence.count} items"

incomes_list = %w[
  salary
  cashback
  gifts
  dividents
]
Income.destroy_all
incomes_list.each do |name|
  Income.create(name: name,
                description: name,
                user_id: 1,
                predefined: true)
end
p "Created #{Income.count} items"
