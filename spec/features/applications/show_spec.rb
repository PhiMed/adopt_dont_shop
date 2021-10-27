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

    visit "/applications/new"

    fill_in('Name', with: 'Caroline Russotti')
    fill_in('Street address', with: '70 Applegate Dr.')
    fill_in('City', with: 'Franklin Square')
    fill_in('State', with: 'NY')
    fill_in('Zip code', with: '11011')
    click_button('Submit')
    fill_in("Search", with: "Hayden")
    click_button('Search')
    click_button('Adopt this pet')
    expect(page).to have_link("Hayden")
  end

  it 'can submit an app' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Hayden", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")

    visit "/applications/new"
    fill_in('Name', with: 'Caroline Russotti')
    fill_in('Street address', with: '70 Applegate Dr.')
    fill_in('City', with: 'Franklin Square')
    fill_in('State', with: 'NY')
    fill_in('Zip code', with: '11011')
    click_button('Submit')
    fill_in("Search", with: "Hayden")
    click_button('Search')
    click_button('Adopt this pet')
    fill_in("reason", with: "I love dogs")
    click_button('Submit')

    expect(page).not_to have_link("Submit")
    expect(page).not_to have_button("Search")
    expect(page).to have_content("Pending")
  end

  it 'can search for pets with partial matches' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Lt. Fluff, USAF", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    pet_2 = Pet.create!(name: "Dr. Fluff MD", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    visit "/applications/new"
    fill_in('Name', with: 'Caroline Russotti')
    fill_in('Street address', with: '70 Applegate Dr.')
    fill_in('City', with: 'Franklin Square')
    fill_in('State', with: 'NY')
    fill_in('Zip code', with: '11011')
    click_button('Submit')
    fill_in("Search", with: "Fluff")
    click_button('Search')

    expect(page).to have_content("Lt. Fluff, USAF")
    expect(page).to have_content("Dr. Fluff MD")
  end

  it 'can search for pets with case-insensitive matches' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Lt. Fluff, USAF", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    pet_2 = Pet.create!(name: "Dr. Fluff MD", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    visit "/applications/new"
    fill_in('Name', with: 'Caroline Russotti')
    fill_in('Street address', with: '70 Applegate Dr.')
    fill_in('City', with: 'Franklin Square')
    fill_in('State', with: 'NY')
    fill_in('Zip code', with: '11011')
    click_button('Submit')
    fill_in("Search", with: "flu")
    click_button('Search')

    expect(page).to have_content("Lt. Fluff, USAF")
    expect(page).to have_content("Dr. Fluff MD")
  end

  it 'displays an error if submitted with the reason field blank' do
    shelter = Shelter.create!(name: "Foothills Animal Shelter", rank: "1", city: "Golden")
    pet_1 = Pet.create!(name: "Hayden", age: "4", adoptable: "true", breed: "Aussie Mix", shelter_id: "#{shelter.id}")
    app_1 = Application.create(name: 'Adam Herrara-Ochoa', street_address: '21',
       city: 'Mexico DF', state: 'DF', zip_code: 12050)

    visit "/applications/#{app_1.id}"
    fill_in("Search", with: "Hayden")
    click_button('Search')
    click_button('Adopt this pet')
    click_button('Submit')

    expect(current_path).to eq("/applications/#{app_1.id}")
    expect(page).to have_content("Error: You must provide a reason")
  end

end
