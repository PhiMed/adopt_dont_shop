require 'rails_helper'

RSpec.describe 'the admin shelters show page' do
  it 'displays the shelter attributes and statistics' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: Shelter.all.first.id)
    Pet.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: Shelter.all.first.id)
    visit "admin/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("Average age of pet: 4.0")
    expect(page).to have_content("Number of adoptable pets: 2")
  end
end
