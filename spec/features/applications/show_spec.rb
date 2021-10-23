require 'rails_helper'

RSpec.describe 'application show page' do
  it 'displays the information of the application' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Hayden", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")

    visit "/applications/new"

    fill_in('Name', with: 'Caroline Russotti')
    fill_in('Street address', with: '70 Applegate Dr.')
    fill_in('City', with: 'Franklin Square')
    fill_in('State', with: 'NY')
    fill_in('Zip code', with: '11011')

    click_button('Submit')

    expect(page).to have_content("Caroline")
    expect(page).to have_content("In Progress")
  end

  it 'can add a pet to the application' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Hayden", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    application_1 = Application.create!(name: "Caroline Russotti",
                                        street_address: "70 Applegate Dr.",
                                        city: "Franklin Square",
                                        state: "NY",
                                        zip_code: "11011")

    visit "/applications/#{application_1.id}"
    expect(page).not_to have_content("Hayden")
    fill_in("Search", with: "Hayden")
    click_button('Search')
    click_button('Adopt this pet')
    expect(page).to have_link("Hayden")
  end
end
