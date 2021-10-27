require 'rails_helper'

RSpec.describe 'the application_pet controller' do

  describe "instance methods" do
    it 'can create an application_pet' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO',
        foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair',
        age: 5, adoptable: true)
      app_1 = Application.create(name: 'Adam', street_address: '21',
         city: 'Mexico DF', state: 'DF', zip_code: 12, application_status: 'Pending')
      app_pet_1 = ApplicationPet.create(pet_id: pet_1.id, application_id: app_1.id, status: "Pending")

      expect(app_pet_1).to be_an_instance_of(ApplicationPet)
    end

    it 'can doesnt let someone apply for the same pet twice' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO',
        foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair',
        age: 5, adoptable: true)
      app_1 = Application.create(name: 'Adam', street_address: '21',
         city: 'Mexico DF', state: 'DF', zip_code: 12)

      visit "/applications/#{app_1.id}"

      fill_in("Search", with: "Mr. Pirate")
      click_button('Search')
      click_button('Adopt this pet')
      fill_in("Search", with: "Mr. Pirate")
      click_button('Search')
      click_button('Adopt this pet')
      expect(page).to have_content("Error: You have alreay applied for this pet")
    end
  end
end
