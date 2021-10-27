require 'rails_helper'

RSpec.describe 'the applications index' do
  it 'lists all the applications' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO',
      foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair',
      age: 5, adoptable: true)
    app_1 = Application.create(name: 'Adam Herrara-Ochoa', street_address: '21',
       city: 'Mexico DF', state: 'DF', zip_code: 12050, application_status: 'Pending')
    app_2 = Application.create(name: 'Juanita Marrero-Sanchez', street_address: '21',
       city: 'Durango', state: 'DG', zip_code: 34000, application_status: 'Pending')

    visit "/applications"

    expect(page).to have_content(app_1.name)
    expect(page).to have_content(app_2.name)
  end
end
