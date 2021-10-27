require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  it 'lists all the admin shelter names' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'Bravo animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Charlies pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    visit "admin/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
  end

  it 'lists the shelters by reverse alphabetical order' do
    a = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    c = Shelter.create(name: 'Charlies pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    b = Shelter.create(name: 'Bravo animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)


    visit "admin/shelters"

    expect(c.name).to appear_before(b.name)
    expect(b.name).to appear_before(a.name)
  end

  it 'lists the shelters with pending applications' do
    a = Shelter.create(name: 'Pending shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    b = Shelter.create(name: 'In Progress animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    pendingpet = Pet.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: a.id)
    inprogresspet = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: b.id)
    pending_app = Application.create!(name: 'Adam', street_address: '21', city: 'Mexico DF', state: 'DF', zip_code: 12, application_status: 'Pending')
    in_progress_app = Application.create!(name: 'Jorge', street_address: '12', city: 'La Paz', state: 'EA', zip_code: 13, application_status: 'In progress')
    ApplicationPet.create!(pet_id: pendingpet.id, application_id: pending_app.id)
    ApplicationPet.create!(pet_id: inprogresspet.id, application_id: in_progress_app.id)

    visit "admin/shelters"

    expect(page).to have_content(a.name)
  end
end
