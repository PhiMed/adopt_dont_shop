require 'rails_helper'

RSpec.describe 'application show page' do
  it 'displays the information of the application' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Hayden", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    application_1 = Application.create!(name: "Caroline Russotti",
                                        street_address: "70 Applegate Dr.",
                                        city: "Franklin Square",
                                        zip_code: "11011")
    ApplicationPet.create!(pet: pet_1, application: application_1)

    visit "/applications/#{application_1.id}"

    save_and_open_page

    expect(page).to have_content("Caroline")
    expect(page).to have_content("Hayden")
    expect(page).to have_link("Hayden")
  end
end
