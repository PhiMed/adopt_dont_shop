# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shelter.find_or_create_by(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
Shelter.find_or_create_by(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
Pet.find_or_create_by(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: Shelter.all.first.id)
Pet.find_or_create_by(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: Shelter.all.first.id)
Pet.find_or_create_by(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: Shelter.all.last.id)
